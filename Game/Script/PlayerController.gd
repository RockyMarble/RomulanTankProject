extends Node

var player_list
onready var button_list := $ButtonList
onready var weapon_list := $OptionButton

var player
var current_player = 0
var amt_dead = 0
var paused = false

#Searches the World for PlayerList and sets it to a variable
#Adds the first child as the current player (WATCH OUT FOR BUGS WITH THIS)
#Connects to "death" signal from each TankRigid object
func _ready():
	for child in get_parent().get_children():
		if child.is_in_group("PlayerList"):
			player_list = child
	for tank in get_tree().get_nodes_in_group("Player"):
		tank.connect("death", self, "_on_Player_death")
		
	player = player_list.get_child(current_player)
	player.update_current_player(true)

func _process(delta):
	if not paused:
		get_button_input()
	if player.dead:
		iterate_player()

#Iterates the list of players to find the next player object
#sets the icon ,indicating which player turn it is, to on or off
#Then sets the current weapon of that player to the optionlist
func iterate_player():
	current_player += 1
	if current_player >= len(get_tree().get_nodes_in_group("Player")):
		current_player = 0
	
	player.update_current_player(false)
	player = player_list.get_child(current_player)
	player.update_current_player(true)
	
	weapon_list.select(player.get_current_weapon())

#Calls shoot function in the player then iterates thru the player
func _on_SHOOT_pressed():
	player.shoot()
	$SoundPlayerShoot.play()
	iterate_player()

#detects for inputs
func get_button_input():
	if $ButtonList/RIGHT.pressed:
		player.move_right()
	elif $ButtonList/LEFT.pressed:
		player.move_left()
	
	if $ButtonList/Plus.pressed:
		player.rotate_right()
	if $ButtonList/Minus.pressed:
		player.rotate_left()
		
	if $ButtonList/Pause.pressed:
		pause()

func pause():
	paused = true
	var menu = load("res://scenes/PauseMenu.tscn").instance()
	add_child(menu)

#sets player weapon to the optionselect
func _on_OptionButton_item_selected(index):
	player.set_current_weapon(index)

func _on_Player_death():
	amt_dead += 1
	if amt_dead >= len(get_tree().get_nodes_in_group("Player")) - 1:
		end_game()
		
# Nothing exciting yet, but the game does end!
# TODO: Scene change, on-screen winner display
func end_game():
	print("Player " + str(current_player + 1) + " Won!")
	yield(get_tree().create_timer(1),"timeout")
	get_tree().change_scene("res://scenes/TitleScreen.tscn")
