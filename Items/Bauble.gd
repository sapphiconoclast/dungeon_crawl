extends "res://Items/Item.gd"

func _ready():
	pass 

func init(new_itemName, new_desc, new_weight, new_cost):
	self.itemName = new_itemName
	self.weight = new_weight
	self.desc = new_desc
	self.cost = new_cost
	return self
