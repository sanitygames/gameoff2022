extends TextureRect

signal hit
signal finished

var word = ""

func set_text(_word):
	print(_word)
	word = _word
	$Label.bbcode_text = formatter(word)

func check_and_next(_str):
	if word.length() == 0:
		return
	if word[0] == _str:
		word.erase(0, 1)
		emit_signal("hit")

	if word == "":
		emit_signal("finished")

	$Label.bbcode_text = formatter(word)

func formatter(_word):
	return "[center][shake]%s![/shake][/center]" % _word


