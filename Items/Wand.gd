extends "res://Items/Item.gd"

var power
var specialty
var duration_bonus
var spellcap
var spells = []
var selected_spell = 0
var hands

func _ready():
	pass 
	
func init(new_itemName, new_desc, new_weight, new_cost, new_power, new_specialty, new_duration_bonus, new_spellcap, new_hands):
	self.itemName = new_itemName
	self.weight = new_weight
	self.desc = new_desc
	self.cost = new_cost
	self.power = new_power
	self.specialty = new_specialty
	self.duration_bonus = new_duration_bonus
	self.spellcap = new_spellcap
	self.hands = new_hands
	for i in self.spellcap:
		spells.append(null)
	return self
