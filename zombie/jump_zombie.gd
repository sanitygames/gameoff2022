extends Node2D

signal destroy

var g = 20.0
var velocity = Vector2.ZERO
var speed = 10.0
var r = 0.0

func _ready():
	velocity.x = lerp(0, 100, randf())
	velocity.y = lerp(-10, -30, randf())
	r = lerp(-10, 10, randf())

func _physics_process(delta):
	velocity.y += g * delta
	position += velocity * delta
	rotation += r * delta


func _on_Timer_timeout():
	queue_free()


func _on_WeaponCollision_body_entered(body:Node):
	var p = Global.get_zombie_particle()
	p.emitting = true
	p.position = position
	get_parent().add_child(p)
	body.queue_free()
	emit_signal("destroy")
	queue_free()
