extends CharacterBody2D
class_name Creature

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var hostile = false
var max_hp
var cur_hp
var max_magicka = 0
var cur_magicka = 0
var max_stamina = 0
var cur_stamina = 0
var armor = 0
var fortitude = 0
var prowess = 0
var intuition = 0
var virtue = 0
var true_speed
var speed
var conditions = []
var condTimer = Timer.new()
var regenTimer = Timer.new()

func _ready():
	add_child(condTimer)
	condTimer.start() 
	condTimer.connect("timeout", Callable(self, "_on_condTimer_timeout"))
	add_child(regenTimer)
	regenTimer.start()
	regenTimer.connect("timeout", Callable(self, "_on_regenTimer_timeout"))
	
func resolve_conditions():
	for cond in conditions:
		if cond.duration > 0:
			cond.duration -= 1
			if cond.condName == "on_fire":
				cur_hp -= cond.intensity
			elif cond.condName == "armor_debuff":
				$acid.visible = true
			elif cond.condName == "cursed":
				cur_hp -= cond.intensity * 3
		else:
			if cond.condName == "frozen":
				self.speed = self.true_speed
			if cond.condName == "armor_debuff":
				$acid.visible = false
			conditions.erase(cond)

func _on_condTimer_timeout():
	resolve_conditions()
	
func _on_regenTimer_timeout():
	if "cleared" in get_parent():
		if !get_parent().cleared:
			cur_stamina = min(max_stamina, cur_stamina + 10)
			cur_magicka = min(max_magicka, cur_magicka + 10)
	
func has_condition(cond):
	var has_cond = false
	for this_cond in conditions:
		if this_cond.condName == cond:
			has_cond = true
	return has_cond

func die():
	pass
