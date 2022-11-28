extends Node2D

signal game_over

func damage():
	var _children = get_children()
	if _children.empty():
		return
	var _c = _children.pop_back().queue_free()
	if _children.size() == 0:
		SoundManager.get_node("GameOver").play()
		emit_signal("game_over")
	else:
		SoundManager.get_node("Damage").play()
