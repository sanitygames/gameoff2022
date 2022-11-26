extends Node2D

export (int) var count = 10

func _ready():
	_update()

func get_weapon():
	if count <= 0:
		return false
	else:
		count -= 1
		_update()
		return true

func add_weapon(value):
	count = min(30, count + value)
	_update()

func _update():
	$Count.text = "x %02d" % count
	$Count.modulate = Color.white if count > 5 else Color.red


func _on_Button2_pressed():
	var res = get_weapon()
	print(res)


func _on_Fukidasi_finished():
	add_weapon(Global.game_level + 1)
