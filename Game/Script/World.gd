extends Node2D

# World loads in levels dynamically
# To keep track of current and next levels

export var lvl_count = 5 # Editable in Scene Editor

onready var lvl_num = 1
onready var level = load("res://scenes/Levels/Level-" + str(lvl_num) + ".tscn").instance()

# Initialize rng for tank colors
onready var rng = RandomNumberGenerator.new()
onready var colors = ["Blue","Green","Red","Yellow"]
onready var temp_colors = colors.duplicate()
onready var color = "Blue"

# Add Level child (incl. Camera2D, PlayerController, PlayerList, and Ground)
# Randomize tank colors
# Iterate & prepare the next level
func _ready():
	add_child(level)
	$Camera2D.queue_free()
	
	rng.randomize()
	color = temp_colors[rng.randi_range(0,3)]
	temp_colors.remove(temp_colors.find(color))
	get_node("Level/Camera2D/PlayerList/Player1").call("change_tank_color",color)
	color = temp_colors[rng.randi_range(0,2)]
	get_node("Level/Camera2D/PlayerList/Player2").call("change_tank_color",color)
	
	
	lvl_num += 1
	level = load("res://scenes/Levels/Level-" + str(lvl_num) + ".tscn").instance()

# Check for end of levels
# If end:
# # Switch to TitleScreen
# Else:
# # Delete previous level
# # Add new level
# # Randomize tank colors
# # Iterate levels
# # # If a next level exists, load it
func change_level():
	if lvl_num > lvl_count:
		get_tree().change_scene("res://scenes/TitleScreen.tscn")
	else: 
		get_node("Level").free()
		add_child(level)
		
		temp_colors = colors.duplicate()
		rng.randomize()
		color = temp_colors[rng.randi_range(0,3)]
		temp_colors.remove(temp_colors.find(color))
		get_node("Level/Camera2D/PlayerList/Player1").call("change_tank_color",color)
		color = temp_colors[rng.randi_range(0,2)]
		get_node("Level/Camera2D/PlayerList/Player2").call("change_tank_color",color)
		
		lvl_num += 1
		if lvl_num <= lvl_count:
			level = load("res://scenes/Levels/Level-" + str(lvl_num) + ".tscn").instance()
			

