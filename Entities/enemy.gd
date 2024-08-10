extends Creature
class_name Enemy

var weapon = InventoryControl.enemy_weapons.get("Fisticuffs")
var enemy_name = "Grunt"

func _ready():
	randomize()
	hostile = true
	cur_hp = 10
	armor = 0
	fortitude = 0
	prowess = 0
	intuition = 0
	virtue = 0
	speed = 30
	true_speed = speed
	global_rotation = 0

func die():
	if enemy_name == "Phalanx Rex":
		var winMessage = get_node("/root/Main/CanvasLayer/WinMessage")
		winMessage.visible = true
		winMessage.global_position.x = get_viewport_rect().size.x/2
		winMessage.global_position.y = get_viewport_rect().size.y/2
	get_parent().enemies.erase(self)
	queue_free()



