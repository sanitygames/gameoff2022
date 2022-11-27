extends Node2D

signal zombie_tutorial_finished

export (Array) var wave_node_pathes

var zombies = 4
var pray_tutorial_progress = 0
var level = "normal"
var tutorial_words = [
	"MOVE",
	"PLEASE",
	"MOVE",
	"MOVE",
	"PLEASE",
]

var normal_level_words = [
	[
		"MOVE",
		"MOVE",
		"PLEASE",
		"PLEASE",
		"PLEASE",
		"HURRYUP",
		"HELPME",
	],
	[
		"GO",
		"MOVE",
		"PLEASE",
	],
	[
		"GO",
		"GO",
		"GO",
		"MOVE",
		"MOVE",
		"PLZ",
	]
]

var hard_level_words = [
	[
		"GO",
		"GO",
		"GO",
		"MOVE",
		"MOVE",
		"MOVE",
		"MOVE",
		"PLEASE",
	],
	[
		"GO",
		"MOVE",
		"PLZ",
	],
	[
		"GO",
		"GO",
		"GO",
		"MOVE",
		"PLZ",
	]
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
	#test
	# $JumpZombieSpawner.is_active = true
	# ゾンビを倒すチュートリアル
	$ZombieTutorialDebug.visible = true
	$Timer.start()
	yield(self, "zombie_tutorial_finished")
	$ZombieTutorialDebug.visible = false

	# タイピングのチュートリアル兼ゲームレベル判定
	$ZombieSpawner.is_active = true
	$PrayTutorialDebug.visible = true
	$Fukidasi.visible = true
	$Timer.wait_time = 999
	while pray_tutorial_progress < tutorial_words.size():
		$Fukidasi.set_text(tutorial_words[pray_tutorial_progress])
		yield($Fukidasi, "finished")
		pray_tutorial_progress += 1
		if pray_tutorial_progress == 2:
			$Timer.start()
			yield(get_tree(), "idle_frame")
	$PrayTutorialDebug.visible = false
	var rest_time = $Timer.time_left
	Global.game_level = rest_time
	$Timer.stop()

	# ノーマルレベル
	while Global.time_left >= 105.0:
		$Fukidasi.set_text(normal_level_words[Global.game_level][randi() % normal_level_words[Global.game_level].size()])
		yield($Fukidasi, "finished")

	# ハードレベル
	while Global.time_left >= 48.0:
		$Fukidasi.set_text(hard_level_words[Global.game_level][randi() % hard_level_words[Global.game_level].size()])
		yield($Fukidasi, "finished")

	$JumpZombieSpawner.is_active = true
	while Global.time_left >= 0.0:
		$Fukidasi.set_text(hard_level_words[Global.game_level][randi() % hard_level_words[Global.game_level].size()])
		yield($Fukidasi, "finished")



func destroy_tutorial_zombie():
	zombies -= 1
	if zombies <= 0:
		emit_signal("zombie_tutorial_finished")

func zombie_tutorial_timer_timeout():
	emit_signal("zombie_tutorial_finished")



