extends Area2D

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		if get_overlapping_bodies().has(SceneControl.player):
			SceneControl.enter_room(get_parent().id, SceneControl.player, "east")
