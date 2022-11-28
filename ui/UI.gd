extends CanvasLayer

var contents = []
var contents_visible = [true, false, false]

func _ready():
	$VolumeWindow.visible = false
	$HelpWindow.visible = false
	var volume = $VolumeWindow/VolumeSlider.value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(volume))

	for child in $HelpWindow/Contents.get_children():
		contents.push_back(child)

func _on_VolumeButton_pressed():
	$VolumeButton.disabled = true
	$VolumeWindow.visible = true

func _on_CloseButton_pressed():
	$VolumeButton.disabled = false
	$VolumeWindow.visible = false

func _on_VSlider_value_changed(value:float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))

func _on_HelpButton_pressed():
	$HelpButton.disabled = true
	$HelpWindow.visible = true


func _on_NextButton_pressed():
	var _v = contents_visible.pop_back()
	contents_visible.push_front(_v)
	_help_window_reload()


func _on_PrevButton_pressed():
	var _v = contents_visible.pop_front()
	contents_visible.push_back(_v)
	_help_window_reload()

func _on_helpwindowCloseButton_pressed():
	$HelpButton.disabled = false
	$HelpWindow.visible = false
	contents_visible = [true, false, false]
	_help_window_reload()

func _help_window_reload():
	for i in contents.size():
		contents[i].visible = contents_visible[i]

