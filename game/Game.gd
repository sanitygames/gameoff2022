extends Node2D

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == BUTTON_LEFT:
			if $GameUILayer/WeaponUI.get_weapon():
				$WeaponSpawner.spawn(event.position)
