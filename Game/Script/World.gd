extends Node2D

# World loads in levels dynamically
# To keep track of current and next levels

export var lvl_count = 5 # Editable in Scene Editor

onready var lvl_num  = 1
onready var level    = load("res://scenes/Levels/Level-" + str(lvl_num) + ".tscn").instance()

# Initialize rng for tank colors
onready var rng         = RandomNumberGenerator.new()
onready var colors      = ["Blue","Green","Red","Yellow"]
onready var temp_colors = colors.duplicate()
onready var color       = "Blue"

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
	
	init_items()
	
	$MusicNode/MusicLevel1.play()
	lvl_num += 1
	level = load("res://scenes/Levels/Level-" + str(lvl_num) + ".tscn").instance()

func init_items():
	rng.randomize()
	for item in $Level/Items.get_children():
		if rng.randi_range(0,1) == 0:
			item.visible = false
			item.set_deferred("monitoring", false)

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
		$MusicNode/MusicLevel5.stop()
		get_tree().change_scene("res://scenes/TitleScreen.tscn")
	else: 
		match lvl_num-1:
			1:
				$MusicNode/MusicLevel1.stop()
			2:
				$MusicNode/MusicLevel2.stop()
			3:
				$MusicNode/MusicLevel3.stop()
			4:
				$MusicNode/MusicLevel4.stop()
			#5:
				#$MusicNode/MusicLevel5.stop()
		get_node("Level").set_name("old")
		get_node("old").queue_free()
		add_child(level)
		
		temp_colors = colors.duplicate()
		rng.randomize()
		color = temp_colors[rng.randi_range(0,3)]
		temp_colors.remove(temp_colors.find(color))
		get_node("Level/Camera2D/PlayerList/Player1").call("change_tank_color",color)
		color = temp_colors[rng.randi_range(0,2)]
		get_node("Level/Camera2D/PlayerList/Player2").call("change_tank_color",color)
		
		init_items()
		
		lvl_num += 1
		if lvl_num <= lvl_count:
			match lvl_num-1:
				2:
					$MusicNode/MusicLevel2.play()
				3:
					$MusicNode/MusicLevel3.play()
				4:
					$MusicNode/MusicLevel4.play()
				#5:
					#$MusicNode/MusicLevel5.play()
			level = load("res://scenes/Levels/Level-" + str(lvl_num) + ".tscn").instance()
		if lvl_num > lvl_count:
			$MusicNode/MusicLevel5.play()


func restart():
	var current_level = load("res://scenes/Levels/Level-" + str(lvl_num -1) + ".tscn").instance()
	var tank_colors = [get_node("Level/Camera2D/PlayerList/Player1").tank_color,get_node("Level/Camera2D/PlayerList/Player2").tank_color]
	get_node("Level").set_name("old")
	get_node("old").queue_free()
	add_child(current_level)
	get_node("Level/Camera2D/PlayerList/Player1").call("change_tank_color",tank_colors[0])
	get_node("Level/Camera2D/PlayerList/Player2").call("change_tank_color",tank_colors[1])
	init_items()
