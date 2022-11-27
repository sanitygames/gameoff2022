extends KinematicBody2D


var velocity = Vector2.ZERO setget set_velocity
var g = 0.0 setget set_gravity

func set_velocity(value):
	velocity = value

func set_gravity(value):
	g = value

func _physics_process(delta):
	velocity.y += g * delta
	var _c = move_and_collide(velocity * delta)


func _on_Timer_timeout():
	queue_free()
