extends CanvasLayer

func _ready():
	$VolumeWindow.visible = false
	var volume = $VolumeWindow/VolumeSlider.value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(volume))


func _on_VolumeButton_pressed():
	$VolumeButton.disabled = true
	$VolumeWindow.visible = true

func _on_CloseButton_pressed():
	$VolumeButton.disabled = false
	$VolumeWindow.visible = false

func _on_VSlider_value_changed(value:float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))
