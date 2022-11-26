extends Node2D

export (PackedScene) var weapon_prefab
export (float) var gravity = 300.0
export (float) var speed = 200.0

var velocity = Vector2.RIGHT



func spawn(_to):
	var w = weapon_prefab.instance()
	w.position = global_position

	var dir = (_to - position).normalized()
	w.velocity = dir * speed
	w.g = gravity
	owner.add_child(w)


