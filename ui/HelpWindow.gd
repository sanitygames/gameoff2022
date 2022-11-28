extends ColorRect

signal closed

var page = 0

func _on_CloseButton_pressed():
	visible = false
	page = 0
	change_page()
	emit_signal("closed")

func _on_NextButton_pressed():
	page = (page + 1) % $Contents.get_child_count()
	change_page()

func _on_PrevButton_pressed():
	page = (page - 1) % $Contents.get_child_count()
	change_page()

func change_page():
	for i in $Contents.get_child_count():
		$Contents.get_child(i).visible =  i == page
