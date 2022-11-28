extends ColorRect

signal closed

func _ready():
	visible = false

func _on_CloseButton_pressed():
	visible = false
	emit_signal("closed")
