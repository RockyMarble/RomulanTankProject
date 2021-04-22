extends Control

var controller
var scene_reset
#var delay = 2
#onready var timer := $Timer

func _ready():
	controller = get_parent()
	scene_reset = controller.get_owner().get_filename()

func _process(delta):
	get_button_input()

func get_button_input():
	if $Resume.pressed:
		$SoundPauseMenu1.play()
		controller.paused = false
		queue_free()
	if $Restart.pressed:
		$SoundPauseMenu3.play()
		controller.get_parent().get_parent().get_parent().call("restart")
	if $Quit.pressed:
		$SoundPauseMenu2.play()
		get_tree().change_scene("res://scenes/TitleScreen.tscn")
