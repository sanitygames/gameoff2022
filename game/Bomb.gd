extends AnimatedSprite

var velocity = Vector2(0, -5)
var g = 5.0

func _ready():
	set_physics_process(false)
	visible = false

func bomb():
	visible = true
	set_physics_process(true)

func _physics_process(delta):
	velocity.y += g * delta
	position += velocity
