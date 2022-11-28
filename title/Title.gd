extends Node2D

func _on_StartButton_pressed():
	SoundManager.play_start()
	var _e = get_tree().change_scene("res://demo/Demo.tscn")
