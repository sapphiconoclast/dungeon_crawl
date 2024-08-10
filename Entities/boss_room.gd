extends Node2D

var active = false
var cleared = false
var enemies = []

func _ready():
	var PRexResource = load("res://Entities/phalanx_rex.tscn")
	var PRex = PRexResource.instantiate()
	add_child(PRex)
	enemies.append(PRex)
	PRex.position.y -= 300
