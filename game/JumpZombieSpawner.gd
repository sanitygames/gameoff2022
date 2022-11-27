extends Node2D

signal jump_zombie_spawn

export (PackedScene) var zombie_prefab

var is_active = false
var curves = []


func _ready():
	for child in get_children():
		if child is Path2D:
			curves.push_back(child.curve)


func spawn():
	var points = curves[randi() % curves.size()].get_baked_points()
	var z = zombie_prefab.instance()
	z.position = points[randi()%points.size()]
	owner.add_child(z)
	$Spawn.play()
	emit_signal("jump_zombie_spawn")


func _on_Timer_timeout():
	if is_active:
		spawn()
