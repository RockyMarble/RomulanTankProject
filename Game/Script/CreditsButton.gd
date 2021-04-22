extends Button

func _on_Credits_pressed():
	$SoundMenu2.play()
	get_tree().change_scene("res://scenes/Credits.tscn")
