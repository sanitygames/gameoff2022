extends Node2D

export (Array) var wave_node_pathes


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == BUTTON_LEFT:
			if $GameUILayer/WeaponUI.get_weapon():
				$WeaponSpawner.spawn(event.position)


func _ready():
	pass



