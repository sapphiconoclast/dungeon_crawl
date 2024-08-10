extends Enemy

func _ready():
	randomize()
	speed = 7
	max_hp = 100
	cur_hp = 100
	global_rotation = 0
	armor = 35
	enemy_name = "Phalanx Rex"

func attack():
	if (!$hitbox.get_overlapping_bodies().is_empty() && !SceneControl.player.dead):
		CombatControl.resolve_attack(self, $hitbox.get_overlapping_bodies()[0], weapon)

