extends CanvasLayer

func _on_VolumeButton_pressed():
	$VolumeButton.disabled = true
	$VolumeWindow.visible = true

func _on_VolumeWindow_closed():
	$VolumeButton.disabled = false

func _on_HelpButton_pressed():
	$HelpButton.disabled = true
	$HelpWindow.visible = true

func _on_HelpWindow_closed():
	$HelpButton.disabled = false
