extends Area2D

var stuff = {}

func _ready():
	randomize()
	$AnimatedSprite2D.play("closed")
	global_rotation = 0
	var things = randi() % 3 +3
	for i in things:
		var chance = randi() % 9
		var temp1
		if (chance == 0):
			var cool_weapon = InventoryControl.Weapons.get(InventoryControl.Weapons.keys()[randi() % InventoryControl.Weapons.size()]).enchant()
			temp1 = {cool_weapon: 1}
		elif (chance == 1):
			temp1 = {InventoryControl.Weapons.get(InventoryControl.Weapons.keys()[randi() % InventoryControl.Weapons.size()]): 1}
		elif (chance == 2):
			temp1 = {InventoryControl.Wands.get(InventoryControl.Wands.keys()[randi() % InventoryControl.Wands.size()]): 1}
		elif (chance == 3):
			temp1 = {InventoryControl.SpellRunes.get(InventoryControl.SpellRunes.keys()[randi() % InventoryControl.SpellRunes.size()]): 1}
		elif (chance == 4):
			temp1 = {InventoryControl.Armors.get(InventoryControl.Armors.keys()[randi() % InventoryControl.Armors.size()]): 1}
		elif (chance < 7):
			temp1 = {InventoryControl.Consumables.get(InventoryControl.Consumables.keys()[0]): 1}
		else:
			temp1 = {InventoryControl.Consumables.get(InventoryControl.Consumables.keys()[randi() % InventoryControl.Consumables.size()]): 1}
		stuff.merge(temp1, false)

func _process(_delta):
	if (Input.is_action_pressed("interact") && get_parent().cleared && SceneControl.player in get_overlapping_bodies()):
		loot()

func loot():
	if get_parent().cleared:
		var temp2
		for thing in stuff.keys():
			if SceneControl.player.inv.has(thing):
				temp2 = {thing: stuff.get(thing)+1}
				SceneControl.player.inv.merge(temp2, true)
			else:
				temp2 = {thing: 1}
				SceneControl.player.inv.merge(temp2, false)
		stuff.clear()
		$AnimatedSprite2D.play("open")
