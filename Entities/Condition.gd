extends Node

var condName
var source
var duration
var intensity

func _ready():
	pass 

func init(new_condName, new_source, new_duration, new_intensity):
	self.condName = new_condName
	self.source = new_source
	self.duration = new_duration
	self.intensity = new_intensity
	return self
