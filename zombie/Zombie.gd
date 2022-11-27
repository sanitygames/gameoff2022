extends Node2D

export (bool) var is_active = true setget set_is_active
export (bool) var is_jump = false
export (int) var animation = -1

signal destroy

const ANIMATION_NAME = ["1", "2"]

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var g = 20.0
var speed = 10.0
var r = 0.0

func set_is_active(value):
	is_active = value
	set_physics_process(is_active)

func _ready():
	var _n = randi() % 2 + 1 if animation == -1 else animation
	var _ns = String(_n)
	$AnimatedSprite.play(_ns, true)

	if is_jump:
		g = 20.0
		velocity.x = lerp(0, 100, randf())
		velocity.y = lerp(-10, -30, randf())
		r = lerp(-10, 10, randf())
	else:
		g = 0.0
		r = 0.0
		velocity = (Global.player_position - position).normalized()

	set_physics_process(is_active)

func _physics_process(_delta):
	velocity.y += g * _delta
	rotation += r * _delta

	var _d = _delta if is_jump else speed
	position += velocity * _d

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.speed_scale = lerp(0.5, 3.0, randf())

func _on_WeaponCollision_body_entered(_body:Node):
	var p = Global.get_zombie_particle()
	p.emitting = true
	p.position = position
	get_parent().add_child(p)
	_body.queue_free()
	emit_signal("destroy")
	queue_free()


func _on_Timer_timeout():
	queue_free()
