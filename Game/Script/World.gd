extends Node2D

onready var level = preload("res://scenes/levels/Level-Angular.tscn").instance()


func _ready():
	add_child(level)
	$Level/PlayerController.connect("game_end",self,"change_level")
	
	$PlayerController2.queue_free()
	$PlayerList.queue_free()
	$Ground.queue_free()
	
	level = preload("res://scenes/levels/Level-CurvedConcave.tscn").instance()

func change_level():
	get_child(1).queue_free() # Delete current level
	add_child(level) # Add new level
	$Level/PlayerController.connect("game_end",self,"change_level") # Reconnect controller
	level = preload("res://scenes/Levels/Level-WinterDark.tscn").instance() # Preload next level
