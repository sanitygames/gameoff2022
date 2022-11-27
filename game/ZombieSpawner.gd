extends Node2D

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
	z.speed = Global.get_zombie_speed()
	owner.add_child(z)


func _on_Timer_timeout():
	if is_active:
		if randf() >= Global.game_level * 0.3:
			spawn()
		$Timer.wait_time = Global.get_zombie_spawn_wait_time()
