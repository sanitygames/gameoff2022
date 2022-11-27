extends Sprite

var origin = Vector2.ZERO

func _ready():
	origin = position
	Global.player_position = position

func shake():
	for i in 10:
		position = origin + Vector2(randi() % 10 - 5, randi() % 10 - 5)
		yield(get_tree(), "idle_frame")
	position = origin


func _on_Fukidasi_hit():
	shake()
