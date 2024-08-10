extends Node

@export var DungeonRoom: PackedScene = load("res://Entities/dungeon_room.tscn")
@export var player_resource: PackedScene = load("res://entities/Player.tscn")
@export var boss_room: PackedScene = load("res://Entities/boss_room.tscn")
var test_mode = false
var rooms = {}

func _ready():
	randomize()
	var player = player_resource.instantiate()
	SceneControl.player = player
	var startRoom = DungeonRoom.instantiate()
	SceneControl.cur_room = startRoom
	startRoom.id = "00"
	startRoom.set_doors(1)
	var temp = {"00": startRoom}
	rooms.merge(temp, false)
	recursive_generate_rooms(0, 16, 1, 0, (randi()%6) + 8)
	print(rooms.size(), " rooms created")
	print(rooms.keys())
	for i in rooms.size():
		var thisRoom = rooms.values()[i]
		add_child(thisRoom)
		thisRoom.position.x = ((i%8)*480)
		thisRoom.position.y = (floor((i/8))*480)
		if rooms.keys()[i] != "00" && thisRoom.get_node("Sprite2D").frame != 1:
			thisRoom.add_chests()
			thisRoom.add_enemies()
		else:
			thisRoom.active = true
	startRoom.add_child(player)
	player.global_position = startRoom.position
	var bossRoom = boss_room.instantiate()
	add_child(bossRoom)
	bossRoom.position.x = -720
	bossRoom.position.y = -720
	var temp2 = {"xx": bossRoom}
	rooms.merge(temp2, false)
	$Camera2D.position = rooms.get("00").get_position()

func recursive_generate_rooms(lowerBound, upperBound, curDepth, bearing, maxDepth):
	if (curDepth < maxDepth && upperBound - lowerBound > 0):
		var split = (lowerBound+upperBound)/2
		var chance = randi() % 200
		if (chance < 40 && curDepth != maxDepth-1):
			var thisRoom = DungeonRoom.instantiate()
			thisRoom.type = "Decision"
			thisRoom.set_doors(3)
			thisRoom.id = str(SceneControl.dec2hex(lowerBound))[1]+str(SceneControl.dec2hex(curDepth))[1]
			thisRoom.rotation = deg_to_rad(bearing)
			rooms.merge({thisRoom.id: thisRoom}, false)
			recursive_generate_rooms(lowerBound, split, curDepth+1, bearing-90, maxDepth)
			recursive_generate_rooms(split, upperBound, curDepth+1, bearing+90, maxDepth)
		else:
			var thisRoom = DungeonRoom.instantiate()
			thisRoom.id = str(SceneControl.dec2hex(lowerBound))[1]+str(SceneControl.dec2hex(curDepth))[1]
			thisRoom.determine_type()
			thisRoom.rotation = deg_to_rad(bearing)
			if (curDepth == maxDepth-1):
				thisRoom.set_doors(-1)
			else:
				thisRoom.set_doors(2)
			rooms.merge({thisRoom.id: thisRoom}, false)
			recursive_generate_rooms(lowerBound, upperBound, curDepth+1, bearing, maxDepth)

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if ($CanvasLayer/InventoryUI.visible):
			$CanvasLayer/InventoryUI.visible = false
			$CanvasLayer/InventoryUI/InventoryList.clear()
		else:
			$CanvasLayer/InventoryUI.visible = true
			$CanvasLayer/InventoryUI.populate()
		if get_tree().paused:
			get_tree().paused = false
		else:
			get_tree().paused = true
	if Input.is_action_just_pressed("test"):
		print("WARNING: TEST MODE ENGAGED")
		test_mode = true
		SceneControl.player.get_starter_gear("")
	update_info()

func update_info():
	var output = "Right: "
	if SceneControl.player.right != null:
		output += SceneControl.player.right.itemName+"\n"
	else:
		output += "none\n"
	output += "Left: "
	if SceneControl.player.left != null:
		output += SceneControl.player.left.itemName+"\n\n"
	else:
		output += "none\n\n"
	output += "Head: "
	if SceneControl.player.armor_slots.head != null:
		output += SceneControl.player.armor_slots.head.itemName+"\n"
	else:
		output += "none\n"
	output += "Arms: "
	if SceneControl.player.armor_slots.arms != null:
		output += SceneControl.player.armor_slots.arms.itemName+"\n"
	else:
		output += "none\n"
	output += "Chest: "
	if SceneControl.player.armor_slots.chest != null:
		output += SceneControl.player.armor_slots.chest.itemName+"\n"
	else:
		output += "none\n"
	output += "Legs: "
	if SceneControl.player.armor_slots.legs != null:
		output += SceneControl.player.armor_slots.legs.itemName+"\n"
	else:
		output += "none\n"
	output += "Feet: "
	if SceneControl.player.armor_slots.feet != null:
		output += SceneControl.player.armor_slots.feet.itemName+"\n\n"
	else:
		output += "none\n\n"
	output += "Total armor: "+ str(SceneControl.player.armor)
	$CanvasLayer/LeftMargin/Equipment.text = output

func _on_death_timer_timeout():
	SceneControl.player.dead = false
	SceneControl.player.get_node("Sprite2D").play("stand", false)
	SceneControl.player.cur_hp = SceneControl.player.max_hp
	SceneControl.player.cur_stamina = SceneControl.player.max_stamina
	SceneControl.player.cur_magicka = SceneControl.player.max_magicka
	SceneControl.player.conditions.clear()
	SceneControl.player.get_node("acid").visible = false
	SceneControl.player.get_parent().remove_child(SceneControl.player)
	$CanvasLayer.scale.x = 1
	$CanvasLayer.scale.y = 1
	get_tree().get_root().set_size_2d_override(false, Vector2(720, 480), Vector2(120, 0))
	rooms.get("00").call_deferred("add_child", SceneControl.player)
	for room in rooms.keys():
		if room == "00":
			rooms.get(room).active = true
		else:
			rooms.get(room).active = false
	$Camera2D.position = rooms.get("00").get_position()
	SceneControl.player.global_position.x = 0
	SceneControl.player.global_position.y = 0
	SceneControl.player.global_rotation = 0
	get_node("CanvasLayer/DeathMessage").visible = false
