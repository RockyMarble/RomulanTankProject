extends Node2D

const section_time := 12.0
const line_time := 0.3
const base_speed := 50.0
const speed_up_multiplier := 3.0
const title_color := Color.blueviolet

var scroll_speed := base_speed
var speed_up := false

onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var credits = [
	[
		"TANKS",
		"",
		"",
		"",
		"",
		"A Romulan Tank Project production",
		"",
		"",
		"",
		""
	],[
		"",
		"-Programming-",
		"",
		"",
		"",
		"",
		"Nat Arney",
		"",
		"",
		"Adrian Lamphier",
		"",
		"",
		"Benjamin Marble",
		"",
		"",
		"Alexander Wilems",
		"",
		"",
		""
	],[
		"",
		"-Level Design-",
		"",
		"",
		"",
		"",
		"Nat Arney",
		"",
		"",
		""
	],[
		"",
		"-Art-",
		"",
		"",
		"",
		"",
		"Alexander Wilems",
		"",
		"",
		""
	],[
		"",
		"-Music-",
		"",
		"",
		"",
		"",
		"Benjamin Marble",
		"",
		"",
		"Adrian Lamphier",
		"",
		"",
		""
	],[
		"",
		"-Sound Effects-",
		"",
		"",
		"",
		"",
		"Benjamin Marble",
		"",
		"",
		""
	],[
		"",
		"-Testers-",
		"",
		"",
		"",
		"",
		"Adrian Lamphier",
		"",
		"",
		"Alexander Wilems",
		"",
		"",
		"Benjamin Marble",
		"",
		"",
		"Nat Arney",
		"",
		"",
		""
	],[
		"",
		"-Tools used-",
		"",
		"",
		"",
		"",
		"Game developed with the Godot Engine",
		"",
		"",
		"https://godotengine.org/license",
		"",
		"",
		"",
		"",
		"Art created with Adobe Fresco and Photoshop",
		"",
		"",
		"https://www.adobe.com/products/fresco.html",
		"",
		"https://www.adobe.com/products/photoshop.html",
		"",
		"",
		"",
		"",
		"Music created with FL studio 9 and FL studio 20",
		"",
		"",
		"https://www.image-line.com/",
		"",
		"",
		"",
		"",
		"Sound effects made with Audacity",
		"",
		"",
		"https://www.audacityteam.org/",
		"",
		"",
		"",
		"",
		""
	],[
		"",
		"-Special thanks-",
		"",
		"",
		"",
		"",
		"",
		"Dr. Ted Lehr",
		"",
		"",
		"- for being an awesome professor that creates fun learning environments",
		"",
		"- for pushing us to be better and learn new things",
		"",
		"- and for giving us a perfect grade *wink wink*",
		"",
		"",
		"",
		"",
		"",
		"Russell Hernandez Ruiz",
		"",
		"",
		"- for all the free playtesting and smiles",
		"",
		"",
		"",
		"",
		"",
		"Tanks2 and FreeOnlineGames",
		"",
		"",
		"- for the inspiration and nostalgia",
		"",
		"",
		"",
		"",
		"",
		"Zapsplat.com",
		"",
		"",
		"- for the limitless sfx possibilities on a student budget",
		"",
		"",
		"",
		"",
		"",
		"You, the player",
		"",
		"- for playing our game",
		"",
		"- No game is complete without players, we appreciate you!!!",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	],[
		"",
		"",
		"Fictitious Disclaimer:",
		"",
		"",
		"",
		"",
		"This video game is protected under the copyright laws of the ",
		"",
		"United States and other countries throughout the world",
		"",
		"",
		"",
		"Country of first publication: United States of America",
		"",
		"",
		"",
		"Any unauthorized exhibition, distribution, or copying of this",
		"",
		"video game or any part thereof (including soundtrack) may result in ",
		"",
		"civil liability and criminal prosecution",
		"",
		"",
		"",
		"The setting, weapons, tanks, and incidents portrayed in this ",
		"",
		"production are fictitious",
		"",
		"",
		"",
		"No identification with actual pixels (living or deceased), places, ",
		"",
		"structures, and items is intended or should be inferred",
		"",
		"",
		"",
		"No person or entity associated with this video game received payment ",
		"",
		"or anything of value, or entered into any agreement, in connection ",
		"",
		"with the depiction of tobacco products",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"No pixels were harmed in the making of this video game",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"Enjoying these beats? Check out Adrian Lamphier's music on Spotify!",
		"",
		"",
		"https://open.spotify.com/artist/1EkCe1wahCsYaSUafaaITA",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"GAME OVER MAN, GAME OVER",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	]
]


func _process(delta):
	scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speed
			if l.rect_position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		
		get_tree().change_scene("res://scenes/TitleScreen.tscn")


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		new_line.add_color_override("font_color", title_color)
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
