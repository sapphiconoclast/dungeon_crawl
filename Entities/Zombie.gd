extends Enemy

func _ready():
	speed = 30
	max_hp = 15
	cur_hp = 15
	armor = 10
	enemy_name = "Zombie"
	$health_bar.max_value = max_hp
	$health_bar.value = max_hp

func _process(delta):
	$health_bar.value = cur_hp
	if get_parent().active && !SceneControl.player.dead:
		walk(delta)

func walk(delta):
	if (abs(SceneControl.player.global_position.x - global_position.x) > 1):
		$Sprite2D.flip_h = SceneControl.player.global_position.x < global_position.x
	velocity = position.direction_to(SceneControl.player.position).rotated(get_parent().rotation) * speed
	move_and_slide()

func attack():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if (collision.get_collider() == SceneControl.player && !collision.get_collider().get_node("blood").visible):
			CombatControl.resolve_attack(self, collision.get_collider(), weapon)

func _on_blood_timer_timeout():
	$blood.visible = false

func _on_attack_timer_timeout():
	if get_parent().active && !SceneControl.player.dead:
		attack()
