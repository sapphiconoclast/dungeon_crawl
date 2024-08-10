extends Node

var player
var cur_room

func _ready():
	pass

func enter_room(roomNum, thisPlayer, direction):
	var oldScene = thisPlayer.get_parent()
	var oldAddress = roomNum
	if oldScene is Node2D:
		oldAddress = oldScene.id
	else:
		oldAddress = "00"
	var main = get_node("/root/Main")
	get_node("/root/Main/CanvasLayer/controls").visible = false
	var newAddress = ""
	if (direction == "north" || direction == "west"):
		newAddress = dec2hex(hex2dec(oldAddress)+1)
	elif (direction == "east"):
		var searchOn = false
		var hexDigits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
		for i in main.rooms.keys().size():
			if (main.rooms.keys()[i] == oldAddress):
				searchOn = true
			if (searchOn && main.rooms.keys()[i][1] == hexDigits[hexDigits.find(oldAddress[1])+1] && main.rooms.keys()[i][0] != oldAddress[0]):
				newAddress = main.rooms.keys()[i]
				searchOn = false
	elif (direction == "south"):
		if (main.rooms.has(str(dec2hex(hex2dec(oldAddress)-1)))):
			newAddress = dec2hex(hex2dec(oldAddress)-1)
		else:
			if (oldAddress[0] == "1"):
				newAddress += "0"
			elif (oldAddress[0] == "2"):
				newAddress += "0"
			elif (oldAddress[0] == "3"):
				newAddress += "2"
			elif (oldAddress[0] == "4"):
				newAddress += "0"
			elif (oldAddress[0] == "5"):
				newAddress += "4"
			elif (oldAddress[0] == "6"):
				newAddress += "4"
			elif (oldAddress[0] == "7"):
				newAddress += "6"
			elif (oldAddress[0] == "8"):
				newAddress += "0"
			elif (oldAddress[0] == "9"):
				newAddress += "8"
			elif (oldAddress[0] == "a"):
				newAddress += "8"
			elif (oldAddress[0] == "b"):
				newAddress += "a"
			elif (oldAddress[0] == "c"):
				newAddress += "8"
			elif (oldAddress[0] == "d"):
				newAddress += "c"
			elif (oldAddress[0] == "e"):
				newAddress += "c"
			elif (oldAddress[0] == "f"):
				newAddress += "e"
			newAddress += dec2hex(int(hex2dec(oldAddress[1]))-1)
	if (newAddress.length() > 2):
		newAddress = newAddress[1] + newAddress[2]
	print("player enters room ", newAddress)
	var newScene = main.rooms.get(newAddress)
	cur_room = newScene
	SceneControl.player = thisPlayer
	oldScene.remove_child(SceneControl.player)
	if (oldScene is Node2D):
		oldScene.active = false
	newScene.active = true
	newScene.call_deferred("add_child", SceneControl.player)
	
	if (direction != "south"):
		SceneControl.player.position = newScene.get_node("south_door").get_position()
	else:
		if newScene.get_child(0).frame == 2 || oldAddress == "01":
			SceneControl.player.position = newScene.get_node("north_door").get_position()
		elif oldScene.id[0] == newScene.id[0]:
			SceneControl.player.position = newScene.get_node("west_door").get_position()
		else:
			SceneControl.player.position = newScene.get_node("east_door").get_position()
	for critter in oldScene.get_children():
		if "summon_timer" in critter:
			oldScene.remove_child(critter)
			newScene.call_deferred("add_child", critter)
			critter.set_deferred("position", player.global_position)
			critter.call_deferred("set_global_rotation_degrees", 0)
	SceneControl.player.call_deferred("set_global_rotation_degrees", 0)
	var camera = get_node("/root/Main/Camera2D")
	camera.position = newScene.get_position()
	if (!newScene.cleared):
		SceneControl.player.cur_stamina = min(SceneControl.player.cur_stamina+20, SceneControl.player.max_stamina)
		SceneControl.player.cur_magicka = min(SceneControl.player.cur_magicka+20, SceneControl.player.max_magicka)
	
func enter_boss_room(thisPlayer):
	var oldScene = thisPlayer.get_parent()
	var newScene = get_node("/root/Main").rooms.get("xx")
	cur_room = newScene
	SceneControl.player = thisPlayer
	oldScene.remove_child(thisPlayer)
	get_node("/root/Main/CanvasLayer").scale.x = 2
	get_node("/root/Main/CanvasLayer").scale.y = 2
	newScene.call_deferred("add_child", thisPlayer)
	oldScene.active = true
	SceneControl.player.call_deferred("set_global_rotation_degrees", 0)
	thisPlayer.position = newScene.position
	thisPlayer.position.y += 300
	get_tree().get_root().set_size_2d_override(true, Vector2(1440, 960), Vector2(0, 0))
	var camera = get_node("/root/Main/Camera2D")
	camera.position = newScene.get_position()
	

func dec2hex(dec):
	var output = ""
	var firstNum = floor(int(dec)/16)
	var first
	if (firstNum < 10):
		first = str(firstNum)
	elif (firstNum == 10):
		first = "a"
	elif (firstNum == 11):
		first = "b"
	elif (firstNum == 12):
		first = "c"
	elif (firstNum == 13):
		first = "d"
	elif (firstNum == 14):
		first = "e"
	elif (firstNum == 15):
		first = "f"
	output += first
	var secondNum = int(dec) % 16
	var second
	if (secondNum < 10):
		second = str(secondNum)
	elif (secondNum == 10):
		second = "a"
	elif (secondNum == 11):
		second = "b"
	elif (secondNum == 12):
		second = "c"
	elif (secondNum == 13):
		second = "d"
	elif (secondNum == 14):
		second = "e"
	elif (secondNum == 15):
		second = "f"
	output += second
	return output
	
func hex2dec(hex):
	var output = 0
	if (hex.length() == 1):
		hex = "0" + hex
	var firstChar = str(hex)[0]
	if (firstChar == "0"):
		pass
	elif (firstChar == "1"):
		output += 16
	elif (firstChar == "2"):
		output += 32
	elif (firstChar == "3"):
		output += 48
	elif (firstChar == "4"):
		output += 64
	elif (firstChar == "5"):
		output += 80
	elif (firstChar == "6"):
		output += 96
	elif (firstChar == "7"):
		output += 112
	elif (firstChar == "8"):
		output += 128
	elif (firstChar == "9"):
		output += 144
	elif (firstChar == "a"):
		output += 160
	elif (firstChar == "b"):
		output += 176
	elif (firstChar == "c"):
		output += 192
	elif (firstChar == "d"):
		output += 208
	elif (firstChar == "e"):
		output += 224
	elif (firstChar == "f"):
		output += 240
	var secondChar = str(hex)[1]
	if (secondChar == "0"):
		pass
	elif (secondChar == "1"):
		output += 1
	elif (secondChar == "2"):
		output += 2
	elif (secondChar == "3"):
		output += 3
	elif (secondChar == "4"):
		output += 4
	elif (secondChar == "5"):
		output += 5
	elif (secondChar == "6"):
		output += 6
	elif (secondChar == "7"):
		output += 7
	elif (secondChar == "8"):
		output += 8
	elif (secondChar == "9"):
		output += 9
	elif (secondChar == "a"):
		output += 10
	elif (secondChar == "b"):
		output += 11
	elif (secondChar == "c"):
		output += 12
	elif (secondChar == "d"):
		output += 13
	elif (secondChar == "e"):
		output += 14
	elif (secondChar == "f"):
		output += 15
	return output

