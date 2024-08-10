extends "res://Items/Item.gd"

var damage
var variance
var stamcost
var powermod
var critchance
var hands
var enchantment = "none"
var strength
var modifier = "none"

func _ready():
	randomize() 

func init(new_itemName, new_desc, new_weight, new_cost, new_damage, new_variance, new_stamcost, new_powermod, new_critchance, new_hands):
	self.itemName = new_itemName
	self.weight = new_weight
	self.desc = new_desc
	self.cost = new_cost
	self.damage = new_damage
	self.variance = new_variance
	self.stamcost = new_stamcost
	self.powermod = new_powermod
	self.critchance = new_critchance
	self.hands = new_hands
	return self

func copy():
	var new_weapon = load("res://Items/Weapon.tscn").instantiate()
	new_weapon.init(self.itemName, self.desc, self.weight, self.cost, self.damage, self.variance, self.stamcost, self.powermod, self.critchance, self.hands)
	return new_weapon

func enchant():
	var enchanted_weapon = self.copy()
	var enchantments = ["fire", "frost", "lightning", "acid", "holy", "unholy"]
	var strengths = [1, 1, 1, 2, 2, 3]
	enchanted_weapon.enchantment = enchantments[randi()%enchantments.size()]
	enchanted_weapon.strength = strengths[randi()%6]
	if enchanted_weapon.enchantment == "fire" && enchanted_weapon.strength == 1:
		enchanted_weapon.itemName += " of Embers"
	elif enchanted_weapon.enchantment == "fire" && enchanted_weapon.strength == 2:
		enchanted_weapon.itemName += " of Flames"
	elif enchanted_weapon.enchantment == "fire" && enchanted_weapon.strength == 3:
		enchanted_weapon.itemName += " of the Inferno"
	elif enchanted_weapon.enchantment == "frost" && enchanted_weapon.strength == 1:
		enchanted_weapon.itemName += " of Chills"
	elif enchanted_weapon.enchantment == "frost" && enchanted_weapon.strength == 2:
		enchanted_weapon.itemName += " of Frostbite"
	elif enchanted_weapon.enchantment == "frost" && enchanted_weapon.strength == 3:
		enchanted_weapon.itemName += " of the Rime"
	elif enchanted_weapon.enchantment == "lightning" && enchanted_weapon.strength == 1:
		enchanted_weapon.itemName += " of Sparks"
	elif enchanted_weapon.enchantment == "lightning" && enchanted_weapon.strength == 2:
		enchanted_weapon.itemName += " of Voltage"
	elif enchanted_weapon.enchantment == "lightning" && enchanted_weapon.strength == 3:
		enchanted_weapon.itemName += " of the Storm"
	elif enchanted_weapon.enchantment == "acid" && enchanted_weapon.strength == 1:
		enchanted_weapon.itemName += " of Melting"
	elif enchanted_weapon.enchantment == "acid" && enchanted_weapon.strength == 2:
		enchanted_weapon.itemName += " of Acidity"
	elif enchanted_weapon.enchantment == "acid" && enchanted_weapon.strength == 3:
		enchanted_weapon.itemName += " of Dissolving"
	elif enchanted_weapon.enchantment == "holy" && enchanted_weapon.strength == 1:
		enchanted_weapon.itemName += " of Good Will"
	elif enchanted_weapon.enchantment == "holy" && enchanted_weapon.strength == 2:
		enchanted_weapon.itemName += " of Consecration"
	elif enchanted_weapon.enchantment == "holy" && enchanted_weapon.strength == 3:
		enchanted_weapon.itemName += " of the Heavens"
	elif enchanted_weapon.enchantment == "unholy" && enchanted_weapon.strength == 1:
		enchanted_weapon.itemName += " of Ill Will"
	elif enchanted_weapon.enchantment == "unholy" && enchanted_weapon.strength == 2:
		enchanted_weapon.itemName += " of Desecration"
	elif enchanted_weapon.enchantment == "unholy" && enchanted_weapon.strength == 3:
		enchanted_weapon.itemName += " of the Grave"
	return enchanted_weapon

func modify():
	var modified_weapon = self.copy()
	var modifications = ["Finely Crafted", "Well-Balanced", "Honed", "Precise"]
	modified_weapon.modifier = modifications[randi()%modifications.size()]
	modified_weapon.name = modified_weapon.modifier+" "+modified_weapon.itemName
	return modified_weapon
