extends "res://Items/Item.gd"

var rating
var slot

func _ready():
	pass 

func init(new_itemName, new_desc, new_weight, new_cost, new_rating, new_slot):
	self.itemName = new_itemName
	self.weight = new_weight
	self.desc = new_desc
	self.cost = new_cost
	self.rating = new_rating
	self.slot = new_slot
	return self

func copy():
	var new_armor = load("res://Items/Armor.tscn").instantiate()
	new_armor.init(self.itemName, self.desc, self.weight, self.cost, self.rating, self.slot)
	return new_armor
