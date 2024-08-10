extends "res://Items/Item.gd"

var effect
var strength
var duration
var rarity

func _ready():
	pass 

func init(new_itemName, new_desc, new_weight, new_cost, new_effect, new_strength, new_duration, new_rarity):
	self.itemName = new_itemName
	self.weight = new_weight
	self.desc = new_desc
	self.cost = new_cost
	self.effect = new_effect
	self.strength = new_strength
	self.duration = new_duration
	self.rarity = new_rarity
	return self
