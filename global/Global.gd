extends Node2D

export (PackedScene) var zombie_particle_prefab

var game_level = 0 setget set_game_level

var player_position = Vector2.ZERO

func get_zombie_particle():
	var p = zombie_particle_prefab.instance()
	return p

func set_game_level(value):
	print(value)
	if value > 995:
		game_level = 2
	elif value > 990:
		game_level = 1
	else:
		game_level = 0

	print(game_level)
