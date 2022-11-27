extends CPUParticles2D

func _ready():
	$AudioStreamPlayer.pitch_scale = lerp(0.5, 1.5, randf())
	$AudioStreamPlayer2.pitch_scale = lerp(0.5, 2.5, randf())

func _on_Timer_timeout():
	queue_free()
