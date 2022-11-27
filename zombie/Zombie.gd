extends Node2D

export (bool) var is_active = true

signal destroy

var frame = 0
var sprite
var direction = Vector2.ZERO
var speed = 0.0

func _ready():
	var animated_sprites = []
	for child in get_children():
		if child is AnimatedSprite:
			animated_sprites.push_back(child)
	var n = randi() % animated_sprites.size()
	for i in animated_sprites.size():
		if i == n:
			sprite = animated_sprites[i]
		else:
			animated_sprites[i].queue_free()

	$FrameTimer.wait_time = randf()

func _physics_process(_delta):
	if is_active:
		var velocity = (Global.player_position - position).normalized()
		position += velocity * speed

func _on_Timer_timeout():
	frame += 1
	sprite.frame = frame % sprite.frames.get_frame_count("default")
	$FrameTimer.wait_time = randf() * randf()


func _on_WeaponCollision_body_entered(_body:Node):
	var p = Global.get_zombie_particle()
	p.emitting = true
	p.position = position
	get_parent().add_child(p)
	_body.queue_free()
	emit_signal("destroy")
	queue_free()
