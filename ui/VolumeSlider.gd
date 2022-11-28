extends VSlider

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))

func _on_VolumeSlider_value_changed(value:float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))
