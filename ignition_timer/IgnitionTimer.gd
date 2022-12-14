extends Node2D

signal ignition_timer_update(rest_time)
signal ignition

export (bool) var is_active = false

export (float) var timer = 300.0

var blink = true

func _physics_process(delta):
	if is_active && !Global.game_over:
		timer -= delta
		emit_signal("ignition_timer_update", timer)
	Global.time_left = timer
	time_update()
	if timer <= 0:
		emit_signal("ignition")
		set_physics_process(false)
		$BlinkTimer.stop()

func _on_BlinkTimer_timeout():
	if is_active:
		blink = !blink

func time_update():
	var c = ":" if blink else " "
	var m = int(timer) / 60
	var s = int(timer) % 60
	$Timer.text = "%d%s%02d" % [m, c, s]

