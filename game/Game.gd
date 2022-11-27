extends Node2D

signal zombie_tutorial_finished

export (Array) var wave_node_pathes

var game_over = false
var game_clear = false
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
	if !game_over:
		if event is InputEventMouseButton:
			if event.is_pressed() && event.button_index == BUTTON_LEFT:
				if $GameUILayer/WeaponUI.get_weapon():
					$WeaponSpawner.spawn(event.position)
		if event is InputEventKey:
			if event.is_pressed() && $Fukidasi.visible:
				$Fukidasi.check_and_next(event.as_text())

func _ready():
	# ゾンビを倒すチュートリアル
	$Timer.start()
	yield(self, "zombie_tutorial_finished")

	# タイピングのチュートリアル兼ゲームレベル判定
	$ZombieSpawner.is_active = true
	$Fukidasi.visible = true
	$Timer.wait_time = 999
	while pray_tutorial_progress < tutorial_words.size():
		$Fukidasi.set_text(tutorial_words[pray_tutorial_progress])
		yield($Fukidasi, "finished")
		pray_tutorial_progress += 1
		if pray_tutorial_progress == 2:
			$Timer.start()
			yield(get_tree(), "idle_frame")
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
		if game_clear:
			break
		$Fukidasi.set_text(hard_level_words[Global.game_level][randi() % hard_level_words[Global.game_level].size()])
		yield($Fukidasi, "finished")

	print("Clear")
	Global.game_clear = true
	$Fukidasi.visible = false
	clear()
	yield($Ending, "animation_finished")
	$Fukidasi.visible = true
	$Fukidasi.set_text("FUCKYOU")
	yield($Fukidasi, "finished")
	$Fukidasi.visible = false
	$Bomb.bomb()
	yield(get_tree().create_timer(5.0), "timeout")
	$Bomb2.play()
	yield(get_tree().create_timer(2.0), "timeout")
	$End.play()
	$GameClearLayer.visible = true






func destroy_tutorial_zombie():
	zombies -= 1
	if zombies <= 0:
		emit_signal("zombie_tutorial_finished")

func zombie_tutorial_timer_timeout():
	emit_signal("zombie_tutorial_finished")


func _on_PlayerCollsion_area_entered(_area:Area2D):
	if !game_clear && !game_over:
		$GameUILayer/LifeUI.damage()


func _on_LifeUI_game_over():
	$BGM.stop()
	$GameOverLayer.visible = true
	game_over = true
	print("gameover")


func _on_StartButton_pressed():
	var _e = get_tree().reload_current_scene()


func _on_IgnitionTimer_ignition():
	game_clear = true


func _on_Button_pressed():
	# クリア時出張っgj
	$GameUILayer/IgnitionTimer.timer = 3.0

func clear():
	$BGM.stop()
	$ZombieSpawner.is_active = false
	$JumpZombieSpawner.is_active = false
	$GameUILayer/IgnitionTimer.set_physics_process(false)
	$Car/Camera2D.current = true
	$Ending.play("main")
