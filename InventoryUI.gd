extends Sprite2D

var wand
var spell
var item

func _ready():
	pass
	
func _process(delta):
	pass

func populate():
	for thing in SceneControl.player.inv.keys():
		var thingName = thing.itemName
		$InventoryList.add_item(thingName)

func _on_item_clicked(index, at_position, mouse_button_index):
	if (mouse_button_index == 1):
		_on_InventoryList_item_selected(index)

func _on_InventoryList_item_selected(index):
	$Label9.text = ""
	$"Label1".text = ""
	$"Label2".text = ""
	$"Label3".text = ""
	$"Label4".text = ""
	$"Label5".text = ""
	$"Label6".text = ""
	$"Label7".text = ""
	$"Label8".text = ""
	$left_button_cover.visible = true
	$middle_button_cover.visible = true
	$right_button_cover.visible = true
	var itemRef = $InventoryList.get_item_text(index)
	item = SceneControl.player.get_item_by_name(itemRef)
	$Label10.text = item.itemName
	$"Label1".text = "Weight: "+str(item.weight)
	$"Label2".text = "Value: "+str(item.cost)
	if ("damage" in item):
		$left_button_cover.visible = false
		$right_button_cover.visible = false
		$"Equip Left".text = "Equip Left"
		$"Equip Right".text = "Equip Right"
		$"Label3".text = "Damage: "+str(item.damage)
		$"Label4".text = "Crit chance: "+str(item.critchance * 100)+"%"
		$"Label5".text = "Stamina: "+str(item.stamcost)
		$"Label6".text = "Power: x"+str(item.powermod)
		$"Label7".text = "Hands: "+str(item.hands)
	elif ("rating" in item):
		$left_button_cover.visible = false
		$"Equip Left".text = "Equip"
		$"Label3".text = "Armor: "+str(item.rating)
		$"Label4".text = "Slot: "+item.slot
	elif ("spellcap" in item):
		$left_button_cover.visible = false
		$right_button_cover.visible = false
		$"Equip Left".text = "Equip Left"
		$"Equip Right".text = "Equip Right"
		$"Label3".text = "Specialty: "+str(item.specialty)
		$"Label4".text = "Hands: "+str(item.hands)
		$"Label5".text = "Power: "+str(item.power)
		$"Label6".text = "Duration: +"+str(item.duration_bonus)
		$"Label7".text = "Spellcap: "+str(item.spellcap)
	elif("mana_cost" in item):
		$left_button_cover.visible = false
		$"Equip Left".text = "Inscribe"
	elif("effect" in item):
		$left_button_cover.visible = false
		$"Equip Left".text = "Use"
	$"Label8".text = "Qty: "+str(SceneControl.player.inv.get(item))
	$descLabel.text = str(item.desc)
	if (item.equipped):
		$Label9.text = item.itemName+" is equipped."

func inscribe_spell(target_spell):
	if (SceneControl.player.left != null && "spellcap" in SceneControl.player.left):
		wand = SceneControl.player.left
	elif (SceneControl.player.right != null && "spellcap" in SceneControl.player.right):
		wand = SceneControl.player.right
	else:
		$Label9.text = "Equip a wand to inscribe this spell onto first."
	if wand != null:
		for spell_index in wand.spells.size():
			if wand.spells[spell_index] != null:
				$"InscriptionMenu".get_children()[spell_index].text = "Slot "+str(spell_index+1)+": "+wand.spells[spell_index].itemName
		for button in $"InscriptionMenu".get_children():
			button.visible = true
		if wand.spellcap < 6:
			$"InscriptionMenu/Slot5".visible = false
		if wand.spellcap < 5:
			$"InscriptionMenu/Slot4".visible = false
		if wand.spellcap < 4:
			$"InscriptionMenu/Slot3".visible = false
		$"InscriptionMenu".visible = true
		return false
	else:
		return true

func _on_Slot0_pressed():
	wand.spells[0] = spell
	$"InscriptionMenu".visible = false
	$Label9.text = "Spell inscribed."

func _on_Slot1_pressed():
	wand.spells[1] = spell
	$"InscriptionMenu".visible = false
	$Label9.text = "Spell inscribed."

func _on_Slot2_pressed():
	wand.spells[2] = spell
	$"InscriptionMenu".visible = false
	$Label9.text = "Spell inscribed."

func _on_Slot3_pressed():
	wand.spells[3] = spell
	$"InscriptionMenu".visible = false
	$Label9.text = "Spell inscribed."

func _on_Slot4_pressed():
	wand.spells[4] = spell
	$"InscriptionMenu".visible = false
	$Label9.text = "Spell inscribed."

func _on_Slot5_pressed():
	wand.spells[5] = spell
	$"InscriptionMenu".visible = false
	$Label9.text = "Spell inscribed."
	
func resolve_consumable(target_item):
	var bars = get_node("/root/Main/CanvasLayer/Bars")
	if target_item.effect == "heal":
		SceneControl.player.cur_hp = min(SceneControl.player.cur_hp+item.strength, SceneControl.player.max_hp)
		bars.get_child(0).value = SceneControl.player.cur_hp
	elif target_item.effect == "restore_stam":
		SceneControl.player.cur_stamina = min(SceneControl.player.cur_stamina+item.strength, SceneControl.player.max_stamina)
		bars.get_child(1).value = SceneControl.player.cur_stamina
	elif target_item.effect == "restore_mag":
		SceneControl.player.cur_magicka = min(SceneControl.player.cur_magicka+item.strength, SceneControl.player.max_magicka)
		bars.get_child(2).value = SceneControl.player.cur_magicka
	if SceneControl.player.inv.get(target_item) > 1:
		var temp_inv = {target_item: SceneControl.player.inv.get(target_item)-1}
		SceneControl.player.inv.merge(temp_inv, true)
	else:
		SceneControl.player.inv.erase(target_item)
		$InventoryList.clear()
		populate()
	$"Label8".text = "Qty: "+str(SceneControl.player.inv.get(target_item))


func _on_left_button_pressed():
	if $InventoryList.get_selected_items().size() > 0:
		item = SceneControl.player.get_item_by_name($InventoryList.get_item_text($InventoryList.get_selected_items()[0]))
		var equip_failed = false
		if ("damage" in item || ("spellcap" in item && !"spellcap" in SceneControl.player.right)):
			if (SceneControl.player.left != null):
				SceneControl.player.left.equipped = false
			SceneControl.player.left = item
		elif ("rating" in item):
			if (item.slot == "head"):
				SceneControl.player.armor_slots.head = item
			elif (item.slot == "chest"):
				SceneControl.player.armor_slots.chest = item
			elif (item.slot == "arms"):
				SceneControl.player.armor_slots.arms = item
			elif (item.slot == "legs"):
				SceneControl.player.armor_slots.legs = item
			elif (item.slot == "feet"):
				SceneControl.player.armor_slots.feet = item
			SceneControl.player.update_armor()
		elif ("mana_cost" in item):
			spell = item
			equip_failed = inscribe_spell(item)
		elif ("spellcap" in SceneControl.player.right):
			$Label9.text = "You can only have one wand equipped at a time."
			equip_failed = true
		elif ("effect" in item):
			resolve_consumable(item)
		if ("Sword" in item.itemName || "Dagger" in item.itemName || "Mace" in item.itemName || "Wand" in item.itemName) && !equip_failed:
			for child in SceneControl.player.get_node("Sprite2D/weapon_frame_left").get_children():
				child.visible = false
		if (!equip_failed && !"effect" in item):
			if ("Sword" in item.itemName):
				SceneControl.player.get_node("Sprite2D/weapon_frame_left/sword").visible = true
			elif ("Dagger" in item.itemName):
				SceneControl.player.get_node("Sprite2D/weapon_frame_left/dagger").visible = true
			elif ("Mace" in item.itemName):
				SceneControl.player.get_node("Sprite2D/weapon_frame_left/mace").visible = true
			elif ("Wand" in item.itemName):
				SceneControl.player.get_node("Sprite2D/weapon_frame_left/wand").visible = true
			$Label9.text = item.itemName+" is equipped."
			item.equipped = true
		elif ("effect" in item):
			if (SceneControl.player.inv.has(item)):
				item = SceneControl.player.get_item_by_name(item.itemName)
			else:
				item = SceneControl.player.inv.keys()[0]
				_on_InventoryList_item_selected(0)

func _on_middle_button_pressed():
	item = SceneControl.player.InventoryControl.Master.get($InventoryList.get_item_text($InventoryList.get_selected_items()[0]))
	SceneControl.player.inv.erase(item)
	$InventoryList.clear()
	populate()

func _on_right_button_pressed():
	if $InventoryList.get_selected_items().size() > 0:
		item = SceneControl.player.get_item_by_name($InventoryList.get_item_text($InventoryList.get_selected_items()[0]))
		var equip_failed = false
		if ("damage" in item || ("spellcap" in item && !"spellcap" in SceneControl.player.right)):
			if SceneControl.player.right != null:
				SceneControl.player.right.equipped = false
			SceneControl.player.right = item
		elif ("rating" in item):
			if (item.slot == "head"):
				SceneControl.player.armor_slots.head = item
			elif (item.slot == "chest"):
				SceneControl.player.armor_slots.chest = item
			elif (item.slot == "arms"):
				SceneControl.player.armor_slots.arms = item
			elif (item.slot == "legs"):
				SceneControl.player.armor_slots.legs = item
			elif (item.slot == "feet"):
				SceneControl.player.armor_slots.feet = item
			SceneControl.player.update_armor()
		elif ("spellcap" in SceneControl.player.left):
			$Label9.text = "You can only have one wand equipped at a time."
			equip_failed = true
		if ("Sword" in item.itemName || "Dagger" in item.itemName || "Mace" in item.itemName || "Wand" in item.itemName) && !equip_failed:
			for child in SceneControl.player.get_node("Sprite2D/weapon_frame_right").get_children():
				child.visible = false
		if (!equip_failed):
			if ("Sword" in item.itemName):
				SceneControl.player.get_node("Sprite2D/weapon_frame_right/sword").visible = true
			elif ("Dagger" in item.itemName):
				SceneControl.player.get_node("Sprite2D/weapon_frame_right/dagger").visible = true
			elif ("Mace" in item.itemName):
				SceneControl.player.get_node("Sprite2D/weapon_frame_right/mace").visible = true
			elif ("Wand" in item.itemName):
				SceneControl.player.get_node("Sprite2D/weapon_frame_right/wand").visible = true
			$Label9.text = item.itemName+" is equipped."
			item.equipped = true
