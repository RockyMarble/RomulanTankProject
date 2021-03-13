extends Node

onready var player_list := $PlayerList
onready var button_list := $ButtonList

var player
var current_player = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player = player_list.get_child(current_player)
	player.update_current_player(true)

func _process(delta):
	get_button_input()

func iterate_player():
	current_player += 1
	if current_player >= player_list.get_child_count():
		current_player = 0
	while !player_list.get_child(current_player).is_in_group("Player"):
		current_player += 1
		if current_player >= player_list.get_child_count():
			current_player = 0
	player.update_current_player(false)
	player = player_list.get_child(current_player)
	player.update_current_player(true)

func _on_SHOOT_pressed():
	print("shoot")
	for child in player.get_children():
			if child.is_in_group("Gun"):
				child.shoot()
				$SoundPlayerShoot.play()
	iterate_player()

func get_button_input():
	if $ButtonList/RIGHT.pressed:
		player.move_right()
	elif $ButtonList/LEFT.pressed:
		player.move_left()
	
	if $ButtonList/Plus.pressed:
		player.rotate_right()
	if $ButtonList/Minus.pressed:
		player.rotate_left()
