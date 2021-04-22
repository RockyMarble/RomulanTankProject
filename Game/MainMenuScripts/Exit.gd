extends Button

func _on_Exit_pressed():
	$SoundMenu3.play()
	get_tree().quit()
