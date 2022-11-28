extends Node2D

export (PackedScene) var weapon_prefab
export (float) var gravity = 300.0
export (float) var speed = 200.0

func spawn(_to):
	var _weapon = weapon_prefab.instance()
	var _dir = (_to - position).normalized()
	_weapon.position = global_position
	_weapon.velocity = _dir * speed
	_weapon.g = gravity
	owner.add_child(_weapon)
