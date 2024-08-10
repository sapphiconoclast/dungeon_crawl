extends Node2D

var id
var type
var active = false
var cleared = false
var enemies = []

@export var zombie_resource: PackedScene

@export var chest_resource: PackedScene

func _ready():
	randomize()
	process_mode = Node.PROCESS_MODE_PAUSABLE
	
func _process(delta):
	var not_cleared = false
	for child in get_children():
		if "cur_hp" in child && (child != SceneControl.player && !"summon_timer" in child):
			not_cleared = true
	cleared = !not_cleared
	if cleared:
		$bar1.visible = false
		$bar2.visible = false
		$bar3.visible = false
		$bar4.visible = false

	if Input.is_action_just_pressed("interact") && cleared:
		if $north_door.get_overlapping_bodies().has(SceneControl.player):
			SceneControl.enter_room(id, SceneControl.player, "north")
		if $east_door.get_overlapping_bodies().has(SceneControl.player):
			SceneControl.enter_room(id, SceneControl.player, "east")
		if $south_door.get_overlapping_bodies().has(SceneControl.player):
			SceneControl.enter_room(id, SceneControl.player, "south")
		if $west_door.get_overlapping_bodies().has(SceneControl.player):
			SceneControl.enter_room(id, SceneControl.player, "west")
	
func determine_type():
	var chance = randi()%5
	if (chance == 0):
		type = "Treasure"
	else:
		type = "Combat"
	
func set_doors(num):
	if (num == 0):
		$Sprite2D.frame = 3
		$south_door.get_child(0).set_disabled(true)
		$west_door.get_child(0).set_disabled(true)
		$bar2.visible = false
		$bar4.visible = false
	elif (num == 1):
		$Sprite2D.frame = 0
		$east_door.get_child(0).set_disabled(true)
		$south_door.get_child(0).set_disabled(true)
		$west_door.get_child(0).set_disabled(true)
		$bar2.visible = false
		$bar3.visible = false
		$bar4.visible = false
	elif (num == 2):
		$Sprite2D.frame = 2
		$bar3.visible = false
		$east_door.get_child(0).set_disabled(true)
		$bar4.visible = false
		$west_door.get_child(0).set_disabled(true)
	elif (num == 3):
		$Sprite2D.frame = 4
		$north_door.get_child(0).set_disabled(true)
		$bar1.visible = false
	elif (num == 4):
		$Sprite2D.frame = 5
	else:
		$Sprite2D.frame = 1
		$north_door.get_child(0).set_disabled(true)
		$east_door.get_child(0).set_disabled(true)
		$west_door.get_child(0).set_disabled(true)
		$Portal.open_portal()

func add_enemies():
	var enemy_count = (randi() % 4) + 2
	#var skeleton_resource = load("res://enemies/Skeleton.tscn")
	#var slime_resource = load("res://enemies/Slime.tscn")
	#var sceyeon_resource = load("res://enemies/Sceyeon.tscn")
	#var clocklurk_resource = load("res://enemies/Clocklurk.tscn")
	#var tonguana_resource = load("res://enemies/Tonguana.tscn")
	for i in enemy_count:
		var thisEnemy
		var chance = randi() % 200
		#if (chance > 160):
		#	thisEnemy = skeleton_resource.instantiate()
		#elif (chance > 120):
		#	thisEnemy = slime_resource.instantiate()
		#elif (chance > 80):
		#	thisEnemy = clocklurk_resource.instantiate()
		#elif (chance > 50):
		#	thisEnemy = tonguana_resource.instantiate()
		#else:
		#	thisEnemy = zombie_resource.instantiate()
		#enemy testing
		thisEnemy = zombie_resource.instantiate()
		add_child(thisEnemy)
		thisEnemy.position.x = (((randi() % 33) + 8) * 10) -240
		thisEnemy.position.y = (((randi() % 33) + 8) * 10) -240
		thisEnemy.global_rotation = 0
		enemies.append(thisEnemy)
		
func add_chests():
	var chests
	if (type == "Treasure"):
		chests = randi() % 3
	elif (type == "Combat"):
		chests = randi() % 2 + 1
	else:
		chests = 0
	for i in chests:
		var chest = chest_resource.instantiate()
		add_child(chest)
		chest.position = Vector2((((randi() % 33) + 8) * 10) -240, (((randi() % 33) + 8) * 10) -240)
