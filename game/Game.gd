extends Node2D

signal zombie_tutorial_finished

var game_over = false
var game_clear = false
var zombies = 4
var pray_tutorial_progress = 0

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
		"MOVE",
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
	],
	[
		"GO",
		"GO",
		"GO",
		"MOVE",
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
	Global.game_over = false
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

	# lv1
	print("lv1")
	yield(_wave(105.0, normal_level_words[Global.game_level]), "completed")

	# lv2
	print("lv2")
	yield(_wave(48.0, hard_level_words[Global.game_level]), "completed")

	# lv3
	print("lv3")
	$JumpZombieSpawner.is_active = true
	yield(_wave(0.0, hard_level_words[Global.game_level]), "completed")

	# ending
	Global.game_clear = true
	$Fukidasi.visible = false
	$BGM.stop()
	$ZombieSpawner.is_active = false
	$JumpZombieSpawner.is_active = false
	$GameUILayer/IgnitionTimer.set_physics_process(false)
	$Car/Camera2D.current = true
	$Ending.play("main")
	$Ignition.play()
	yield(get_tree().create_timer(10.0), "timeout")
	$Fly.play()
	yield($Ending, "animation_finished")
	$Fukidasi.visible = true
	$Fukidasi.set_text("FUCKYOU")
	yield($Fukidasi, "finished")
	$Fukidasi.visible = false
	$Bomb.bomb()
	yield(get_tree().create_timer(5.0), "timeout")
	$Bomb2.play()
	$GameClearBGLayer.visible = true
	yield(get_tree().create_timer(2.0), "timeout")
	$Fly.stop()
	$End.play()
	$GameClearLayer.visible = true

func _wave(_limit, _words):
	while Global.time_left >= _limit:
		$Fukidasi.set_text(_words[randi() % _words.size()])
		yield($Fukidasi, "finished")

func destroy_tutorial_zombie():
	zombies -= 1
	if zombies <= 0:
		emit_signal("zombie_tutorial_finished")

func zombie_tutorial_timer_timeout():
	emit_signal("zombie_tutorial_finished")


func _on_PlayerCollsion_area_entered(_area:Area2D):
	_area.owner.set_physics_process(false)
	if !game_clear && !game_over:
		$GameUILayer/LifeUI.damage()


func _on_LifeUI_game_over():
	$BGM.stop()
	$GameOverLayer.visible = true
	$GameOverLayer/StartButton.visible = false
	yield(get_tree().create_timer(1.0), "timeout")
	$GameOverLayer/StartButton.visible = true
	game_over = true
	Global.game_over = true
	print("gameover")


func _on_StartButton_pressed():
	var _e = get_tree().reload_current_scene()


func _on_IgnitionTimer_ignition():
	game_clear = true
	$Fukidasi.emit_signal("finished")

