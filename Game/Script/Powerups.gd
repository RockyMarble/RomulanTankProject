extends Node2D

const MIN_ROUNDS = 2
const MAX_ROUNDS = 10
const MIN_HP_UP = 10
const MAX_HP_UP = 50
var rounds = 0
var rng = RandomNumberGenerator.new()
var p_player

func choose_powerup(player):
	p_player = player
	rng.randomize()
	var num = rng.randi_range(1,3)
	if num == 1:
		health_up()
	elif num == 2:
		shield()
	else:
		spd_up()
	
func health_up():
	p_player.hp += rng.randi_range(MIN_HP_UP,MAX_HP_UP)
	if p_player.hp > 100:
		p_player.hp = 100
	p_player.update_hp()
	p_player.get_node("AnimationPlayer").play("Health")
	
func shield():
	p_player.rounds = rng.randi_range(MIN_ROUNDS,MAX_ROUNDS)
	p_player.powerup = 2
	p_player.get_node("AnimationPlayer").play("Shield")

func spd_up():
	p_player.rounds = rng.randi_range(MIN_ROUNDS,MAX_ROUNDS)
	p_player.powerup = 3
	p_player.get_node("AnimationPlayer").play("Speed")
