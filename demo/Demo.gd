extends Node2D

export (PackedScene) var next_scene

func _input(event):
	if event.is_action_pressed("skip"):
		var _e = get_tree().change_scene_to(next_scene)

func _on_AnimationPlayer_animation_finished(_anim_name:String):
	var _e = get_tree().change_scene_to(next_scene)
