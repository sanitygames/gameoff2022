extends Node2D

signal game_over

var life = 3
var sprites = []

func _ready():
	for child in get_children():
		if child is Sprite:
			sprites.push_back(child)


func damage():
	if life <= 0:
		return

	life -= 1
	var s = sprites.pop_back()
	s.visible = false
	if life <= 0:
		$GameOver.play()
		emit_signal("game_over")
	else:
		$Damage.play()


func _on_Button_pressed():
	damage()
