extends Node2D

export (PackedScene) var zombie_prefab

var curve


func _ready():
	curve = get_node("Path2D").curve


func spawn():
	var points = curve.get_baked_points()
	var z = zombie_prefab.instance()
	z.position = points[randi()%points.size()]
	owner.add_child(z)
	# print(curve.get_baked_points()[randi() % curve.get_baked_points().size()])
	# timer += delta
	# var max_points = curve.get_baked_points().size()
	# # 3.0秒で終端に移動するようにする
	# var rate = timer / 3.0
	# if rate < 1.0:
	# 	var idx = (max_points * rate)
	# 	icon.position = curve.get_baked_points()[idx]


func _on_Timer_timeout():
	spawn()
