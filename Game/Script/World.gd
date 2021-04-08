extends Node2D

# World loads in levels dynamically
# To keep track of current and next levels

export var lvl_count = 3 # Editable in Scene Editor
onready var lvl_num = 1
onready var level = load("res://scenes/levels/Level-" + str(lvl_num) + ".tscn").instance()


# Add Level child (incl. PlayerController, PlayerList, and Ground
# Connect to PlayerController game_end signal
# Prepare the next level
func _ready():
	add_child(level)
	$Level/PlayerController.connect("game_end",self,"change_level")
	
	lvl_num += 1
	level = load("res://scenes/levels/Level-" + str(lvl_num) + ".tscn").instance()

# Check for end of levels
# If end:
# # Switch to TitleScreen
# Else:
# # Delete previous level
# # Add new level
# # Reconnect controller
# # Iterate levels
# # # If a next level exists, load it
func change_level():
	if lvl_num > lvl_count:
		get_tree().change_scene("res://scenes/TitleScreen.tscn")
	else: 
		get_child(1).queue_free()
		add_child(level)
		$Level/PlayerController.connect("game_end",self,"change_level")
		lvl_num += 1
		if lvl_num <= lvl_count:
			level = load("res://scenes/Levels/Level-" + str(lvl_num) + ".tscn").instance()
