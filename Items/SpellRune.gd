extends "res://Items/Item.gd"

var effect
var strength
var variance
var intensity
var mana_cost

func _ready():
	pass 

func init(new_itemName, new_desc, new_weight, new_cost, new_effect, new_strength, new_variance, new_intensity, new_mana_cost):
	self.itemName = new_itemName
	self.weight = new_weight
	self.desc = new_desc
	self.cost = new_cost
	self.effect = new_effect
	self.strength = new_strength
	self.variance = new_variance
	self.intensity = new_intensity
	self.mana_cost = new_mana_cost
	return self
