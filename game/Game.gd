extends Node2D

signal zombie_tutorial_finished

export (Array) var wave_node_pathes

var zombies = 4

var is_pray_tutorial_finished = false
var pray_tutorial_progress = 0
var tutorial_words = [
	"MOVE",
	"PLEASE",
	"MOVE",
	"MOVE",
	"PLEASE",
]

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == BUTTON_LEFT:
			if $GameUILayer/WeaponUI.get_weapon():
				$WeaponSpawner.spawn(event.position)
	if event is InputEventKey:
		if event.is_pressed() && $Fukidasi.visible:
			$Fukidasi.check_and_next(event.as_text())

func _ready():
	$ZombieTutorialDebug.visible = true
	$Timer.start()
	yield(self, "zombie_tutorial_finished")
	$ZombieTutorialDebug.visible = false
	$PrayTutorialDebug.visible = true
	$Fukidasi.visible = true
	while pray_tutorial_progress < tutorial_words.size():
		$Fukidasi.set_text(tutorial_words[pray_tutorial_progress])
		yield($Fukidasi, "finished")
		pray_tutorial_progress += 1
	$PrayTutorialDebug.visible = false


func destroy_tutorial_zombie():
	zombies -= 1
	if zombies <= 0:
		emit_signal("zombie_tutorial_finished")

func zombie_tutorial_timer_timeout():
	emit_signal("zombie_tutorial_finished")



