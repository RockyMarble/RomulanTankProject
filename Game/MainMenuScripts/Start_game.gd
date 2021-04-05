extends Button

#export(String) var scene_to_load



func _on_Start_Game_pressed():
	get_tree().change_scene("res://scenes/World.tscn")
