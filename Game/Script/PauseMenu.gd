extends Control

var controller
var scene_reset

func _ready():
	controller = get_parent()
	scene_reset = controller.get_owner().get_filename()

func _process(delta):
	get_button_input()

func get_button_input():
	if $Resume.pressed:
		controller.paused = false
		queue_free()
	if $Restart.pressed:
		get_tree().change_scene(scene_reset)
	if $Quit.pressed:
		get_tree().change_scene("res://scenes/TitleScreen.tscn")
