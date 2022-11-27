extends Node2D

export (PackedScene) var next_scene

func _on_StartButton_pressed():
	SoundManager.play_start()
	var _e = get_tree().change_scene_to(next_scene)
