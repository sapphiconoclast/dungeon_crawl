extends Node

var condition_resource = load("res://Entities/Condition.tscn")
var projectile_resource = load("res://Entities/Projectile.tscn")
@export var damage_resource: PackedScene

func _ready():
	randomize()
	damage_resource = preload("res://Entities/DamageObject.tscn")

func resolve_attack(attacker, target, weapon):
	var dmg = attacker.prowess + weapon.damage
	if (weapon.variance > 0):
		dmg += randi() % weapon.variance
	if target.has_condition("cursed"):
		for cond in target.conditions:
			if cond.condName == "cursed":
				dmg += cond.intensity
	var critroll = randi() % 100 - attacker.virtue
	var is_power
	if (Input.is_action_pressed("empower") && attacker == SceneControl.player):
		if (attacker.cur_stamina >= weapon.stamcost):
			is_power = true
	if (is_power):
		dmg *= weapon.powermod
		attacker.cur_stamina -= weapon.stamcost
	if (critroll as float/100 <= weapon.critchance):
		dmg *= 2
	var dmg_obj = damage_resource.instantiate().init(attacker, target, dmg, 0, weapon.enchantment, weapon.strength)
	resolve_damage_object(dmg_obj)

func resolve_cast(caster, target, wand, spell):
	if (caster.cur_magicka >= spell.mana_cost):
		caster.cur_magicka -= spell.mana_cost
		if spell.effect == "RangedDamage":
			var dmg_object = damage_resource.instantiate().init(caster, spell.strength * wand.power, spell.variance)
			var missile = projectile_resource.instantiate().set_values(caster.position, Vector2(get_viewport().get_mouse_position().x-360, get_viewport().get_mouse_position().y-240).rotated(0-caster.get_parent().rotation), 30, "magic_missile", dmg_object)
			caster.get_parent().add_child(missile)
		if spell.effect.starts_with("Summon"):
			SceneControl.player.get_parent().add_child(load("res://Summons/Vulpite.tscn").instantiate())

func resolve_damage_object(object):
	resolve_element(object)
	var armor_mod = 0
	if object.target != null:
		if object.target.has_condition("armor_debuff"):
			for cond in object.target.conditions:
				if cond.condName == "armor_debuff":
					armor_mod -= cond.intensity
	var dmg = object.base
	if object.variance > 0:
		dmg += randi() % object.variance
	var final_armor = object.target.armor + armor_mod
	dmg = floor(dmg * (1.0 - (final_armor as float/100)))
	object.target.cur_hp -= max(dmg, 0)
	object.target.get_node("blood").visible = true
	object.target.get_node("blood_timer").start()
	if (object.target.cur_hp <= 0):
		object.target.die()
		
func resolve_element(object):
	var condition = condition_resource.instantiate().init("null", object.dealer, object.dealer.virtue, object.element_strength)
	if object.element == "fire":
		condition.condName = "on_fire"
	elif object.element == "frost":
		condition.condName = "frozen"
		object.target.speed -= (condition.intensity)
	elif object.element == "lightning":
		chain_lightning(object)
	elif object.element == "acid":
		condition.condName = "armor_debuff"
	elif object.element == "unholy":
		condition.condName = "cursed"
	var already_had_condition = false
	for extant_cond in object.target.conditions:
		if extant_cond.condName == condition.condName:
			extant_cond.duration = max(extant_cond.duration, object.dealer.virtue)
			already_had_condition = true
	if !already_had_condition:	
		if (condition.condName != "null"):
			object.target.conditions.append(condition)

func chain_lightning(object):
	var chance = randi()%5
	if chance == 0 && object.target.get_parent().enemies.size() > 1:
		var new_target = object.target.get_parent().enemies[randi() % object.target.get_parent().enemies.size()]
		var bolt = load("res://odds_n_ends/lightning_bolt.tscn").instantiate()
		bolt.add_point(object.target.position)
		bolt.add_point(new_target.position)
		bolt.width = 10
		object.target.get_parent().add_child(bolt)
		var new_object = damage_resource.instantiate().init(object.dealer, new_target, object.base, object.variance, object.element, object.element_strength-1)
		resolve_damage_object(new_object)
