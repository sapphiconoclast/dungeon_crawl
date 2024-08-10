extends Creature
class_name Player

var right_attacking = false
var left_attacking = false
var can_travel = true
var dead = false
var armor_slots = {"head": null, "arms": null, "chest": null, "legs": null, "feet": null}
var left
var right
var inv = {}

@onready var blood_timer = get_node("blood_timer")

func _ready():
	$Sprite2D.play("stand", false)
	$blood.visible = false
	get_starter_gear("")
	armor = 0
	update_armor()
	fortitude = 4
	prowess = 4
	intuition = 4
	virtue = 4
	max_hp = 150 + (fortitude * 10)
	cur_hp = max_hp
	max_magicka = 50 + (intuition * 10)
	cur_magicka = max_magicka
	max_stamina = 50 + (prowess * 10)
	cur_stamina = max_stamina
	speed = 300
	true_speed = speed
	var bars = get_node("/root/Main/CanvasLayer/Bars")
	bars.get_child(0).max_value = max_hp
	bars.get_child(1).max_value = max_stamina
	bars.get_child(2).max_value = max_magicka

func _process(_delta):
	if Input.is_action_just_pressed("attack_main") && right != null && $attack_timer.is_stopped():
		$Sprite2D.play("attack2", true)
		$attack_timer.start()
		if "damage" in right:
			right_attacking = true
		elif "spellcap" in right:
			if right.spells[right.selected_spell] != null:
				CombatControl.resolve_cast(self, get_viewport().get_mouse_position(), right, right.spells[right.selected_spell])
	if Input.is_action_just_pressed("attack_off") && left != null && $attack_timer.is_stopped():
		$Sprite2D.play("attack3", false)
		$attack_timer.start()
		if "damage" in left:
			for area in $stab_range.get_overlapping_areas():
				if (area.get_parent().has_method("attack") && !"summon_timer" in area.get_parent()):
					CombatControl.resolve_attack(self, area.get_parent(), SceneControl.player.left)
		elif "spellcap" in left:
			if left.spells[left.selected_spell] != null:
				CombatControl.resolve_cast(self, get_viewport().get_mouse_position(), left, left.spells[left.selected_spell])
	if (!dead):
		var velocity = Vector2() # The player's movement vector.
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		set_velocity(velocity)
		move_and_slide()
		if !$attack_timer.is_stopped():
			for i in get_slide_collision_count():
				var collision = get_slide_collision(i)
				if (collision.get_collider().has_method("attack") && !"summon_timer" in collision.get_collider() && !collision.get_collider().get_node("blood").visible):
					if right_attacking:
						CombatControl.resolve_attack(self, collision.get_collider(), SceneControl.player.right)
					if left_attacking:
						CombatControl.resolve_attack(self, collision.get_collider(), SceneControl.player.left)
		if velocity.x != 0:
			$Sprite2D.flip_h = velocity.x < 0
		#right weapon animation
		if ($Sprite2D.animation == "attack2" && $Sprite2D.frame == 0):
			if ($Sprite2D.flip_h):
				$Sprite2D/weapon_frame_right.position = Vector2(-10, -35)
				$Sprite2D/weapon_frame_right.rotation = deg_to_rad(20)
			else:
				$Sprite2D/weapon_frame_right.position = Vector2(10, -35)
				$Sprite2D/weapon_frame_right.rotation = deg_to_rad(-20)
		elif ($Sprite2D.animation == "attack2" && $Sprite2D.frame == 1):
			if ($Sprite2D.flip_h):
				$Sprite2D/weapon_frame_right.position = Vector2(-25, 4)
				$Sprite2D/weapon_frame_right.rotation = deg_to_rad(-80)
			else:
				$Sprite2D/weapon_frame_right.position = Vector2(25, 4)
				$Sprite2D/weapon_frame_right.rotation = deg_to_rad(80)
		else:
			if ($Sprite2D.flip_h):
				$Sprite2D/weapon_frame_right.position = Vector2(-20, -8)
				$Sprite2D/weapon_frame_right.rotation = deg_to_rad(-16)
			else:
				$Sprite2D/weapon_frame_right.position = Vector2(20, -8)
				$Sprite2D/weapon_frame_right.rotation = deg_to_rad(16)
		#left weapon animation
		if ($Sprite2D.animation == "attack3" && $Sprite2D.frame == 0):
			if ($Sprite2D.flip_h):
				$Sprite2D/weapon_frame_left.position = Vector2(6, -31)
				$Sprite2D/weapon_frame_left.rotation = deg_to_rad(-40)
			else:
				$Sprite2D/weapon_frame_left.position = Vector2(-6, -31)
				$Sprite2D/weapon_frame_left.rotation = deg_to_rad(40)
		elif ($Sprite2D.animation == "attack3" && $Sprite2D.frame == 1):
			if ($Sprite2D.flip_h):
				$Sprite2D/weapon_frame_left.position = Vector2(24, 6)
				$Sprite2D/weapon_frame_left.rotation = deg_to_rad(80)
			else:
				$Sprite2D/weapon_frame_left.position = Vector2(-24, 6)
				$Sprite2D/weapon_frame_left.rotation = deg_to_rad(-80)
		else:
			if ($Sprite2D.flip_h):
				$Sprite2D/weapon_frame_left.position = Vector2(-4, -5)
				$Sprite2D/weapon_frame_left.rotation = deg_to_rad(-60)
			else:
				$Sprite2D/weapon_frame_left.position = Vector2(4, -5)
				$Sprite2D/weapon_frame_left.rotation = deg_to_rad(60)
	if right != null:
		$Sprite2D/weapon_frame_right.visible = true
	if left != null:
		$Sprite2D/weapon_frame_left.visible = true
	var bars = get_node("/root/Main/CanvasLayer/Bars")
	bars.get_child(0).value = cur_hp
	bars.get_child(1).value = cur_stamina
	bars.get_child(2).value = cur_magicka



func _on_attack_timer_timeout():
	right_attacking = false
	left_attacking = false
	$stab_range.disabled =  false
	if (!dead):
		$Sprite2D.play("stand", false)
	
func _on_blood_timer_timeout():
	$blood.visible = false

func die():
	$Sprite2D.play("die", false)
	dead = true
	var deathMessage = get_node("/root/Main/CanvasLayer/DeathMessage")
	deathMessage.visible = true
	deathMessage.global_position.x = get_tree().get_root().size.x/2
	deathMessage.global_position.y = get_tree().get_root().size.y/2
	get_node("/root/Main/death_timer").start()
	
func get_starter_gear(playerClass):
	if playerClass == "":
		var startWeapon = InventoryControl.Weapons.get("Iron Sword").copy()
		#var startWand = InventoryControl.Wands.get("Magewood Wand")
		var startHelmet = InventoryControl.Armors.get("Leather Helmet").copy()
		var startChestplate = InventoryControl.Armors.get("Leather Breastplate").copy()
		var startVambraces = InventoryControl.Armors.get("Leather Vambraces").copy()
		var startLeggings = InventoryControl.Armors.get("Leather Leggings").copy()
		var startGreaves = InventoryControl.Armors.get("Leather Greaves").copy()
		right = startWeapon
		#left = startWand
		armor_slots.head = startHelmet
		armor_slots.chest = startChestplate
		armor_slots.arms = startVambraces
		armor_slots.legs = startLeggings
		armor_slots.feet = startGreaves
		var temp = {
			startWeapon: 1,
			#startWand: 1,
			startHelmet: 1,
			startChestplate: 1,
			startVambraces: 1,
			startLeggings: 1,
			startGreaves: 1
		}
		inv.merge(temp, false)
		for gear in inv.keys():
			gear.equipped = true
			add_child(gear)
	update_armor()

func update_armor():
	self.armor = 0
	for piece in armor_slots.values():
		if ("rating" in piece):
			self.armor += piece.rating
			
func get_item_by_name(itemName):
	var thisItem
	for item in inv.keys():
		if item.itemName == itemName:
			thisItem = item
	return thisItem
