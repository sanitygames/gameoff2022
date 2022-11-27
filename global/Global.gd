extends Node2D

export (PackedScene) var zombie_particle_prefab
export (Curve) var wait_time_curve
export (Curve) var zombie_speed_curve

var game_level = 0 setget set_game_level

var player_position = Vector2.ZERO

var time_left = 999.9

var game_clear = false
var game_over = false

func get_zombie_particle():
	var p = zombie_particle_prefab.instance()
	return p

func set_game_level(value):
	print(value)
	if value > 995:
		game_level = 0
	elif value > 990:
		game_level = 1
	else:
		game_level = 2

	print(game_level)


func get_zombie_speed():
	var progress = (180.0 - time_left) / 180.0
	var speed = zombie_speed_curve.interpolate(progress) * lerp(randf(), 0.3, 0.5) + 0.1
	return speed

func get_zombie_spawn_wait_time():
	var progress = (180.0 - time_left) / 180.0
	var wait_time = wait_time_curve.interpolate(progress) * 5.0 + 0.4
	return wait_time

