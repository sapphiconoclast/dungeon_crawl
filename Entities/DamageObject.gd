extends Node

var dealer
var target
var base
var variance
var element
var element_strength

func _ready():
	pass 
	
func init(new_dealer, new_target, new_base, new_variance = 0, new_element = "none", new_element_strength = 0):
	self.dealer = new_dealer
	self.target = new_target
	self.base = new_base
	self.variance = new_variance
	self.element = new_element
	self.element_strength = new_element_strength
	return self
