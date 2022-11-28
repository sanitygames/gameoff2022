extends Node2D

func _on_AnimationPlayer_animation_finished(_anim_name:String):
	_goto_next_scene()

func _on_StartButton_pressed():
	_goto_next_scene()

func _goto_next_scene():
	var _e = get_tree().change_scene("res://game/Game.tscn")
