extends TextureRect

func set_text(_word):
	$Label.bbcode_text = formatter(_word)

func formatter(_word):
	return "[center][shake]%s![/shake][/center]" % _word


