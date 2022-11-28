extends KinematicBody2D

var velocity = Vector2.ZERO
var g = 0.0

func _physics_process(delta):
	velocity.y += g * delta
	var _c = move_and_collide(velocity * delta)

func _on_Timer_timeout():
	queue_free()
