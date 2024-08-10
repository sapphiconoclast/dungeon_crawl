extends Area2D

func _ready():
	pass # Replace with function body.
	
func open_portal():
	$Sprite2D.visible = true
	$CollisionShape2D.disabled = false

func _on_Portal_body_entered(body):
	SceneControl.enter_boss_room(body)

func _process(delta):
	$Sprite2D.rotation += deg_to_rad(.5)
