extends Sprite

onready var origin = position

func shake():
	for i in 10:
		position = origin + Vector2(randi() % 10 - 5, randi() % 10 - 5)
		yield(get_tree(), "idle_frame")
		position = origin





func _on_JumpZombieSpawner_jump_zombie_spawn():
	shake()
