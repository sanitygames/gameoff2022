extends Node2D

export (PackedScene) var zombie_particle_prefab

func get_zombie_particle():
	var p = zombie_particle_prefab.instance()
	return p
