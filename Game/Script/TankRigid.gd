extends RigidBody2D

var normal_speed_max = 100
var slow_speed_max = 50
var left_vector = Vector2(-30, 0)
var right_vector = Vector2(30, 0)
var hp = 100
var hp_max = 100
var fuel = 300
var fuel_max = 300
var current_weapon = 0

var flipping = false
var dead = false
var touching = false

var rng = RandomNumberGenerator.new()
var tank_color = "Green"
var powerup = 0
var rounds = 0

signal death

onready var gun := $Gun

func _integrate_forces(state):
	keep_upright()

func _physics_process(delta):
	var speed = normal_speed_max
	if touching:
		speed = slow_speed_max
	if powerup == 3: # Speedup
		speed += 50
	linear_velocity.x = clamp(linear_velocity.x, -speed, speed)
	


func move_left():
	if fuel > 0:
		if !touching:
			apply_central_impulse(left_vector)
			$DirtParticles.throw_dirt()
			update_fuel(-1)
		else:
			apply_central_impulse(left_vector)
			update_fuel(-2)

func move_right():
	if fuel > 0:
		if !touching:
			apply_central_impulse(right_vector)
			$DirtParticles.throw_dirt()
			update_fuel(-1)
		else:
			apply_central_impulse(right_vector)
			update_fuel(-2)

func keep_upright():
	if rotation_degrees < -25:
		apply_torque_impulse(850)
	if rotation_degrees > 25:
		apply_torque_impulse(-850)

func rotate_left():
	$Gun.rotation_degrees -= 1

func rotate_right():
	$Gun.rotation_degrees += 1

func update_hp():
	$HitPoints/Label.text = "HP: " + str(hp)
	$HitPoints.run_resize(hp,hp_max)
	
func update_fuel(amt):
	if fuel + amt < 0:
		fuel = 0
	elif fuel + amt > fuel_max:
		fuel = fuel_max
	else:
		fuel += amt
	$Fuel/Label.text = "FUEL: " + str(fuel)
	$Fuel.run_resize(fuel,fuel_max)

func powerup_check():
	if rounds > 0:
		rounds -= 1
	else:
		if powerup > 0:
			if powerup == 2:
				$AnimationPlayer.play("ShieldDown")
			elif powerup == 3:
				$AnimationPlayer.play("SpeedDown")
			powerup = 0
		else:
			rng.randomize()
			var num = rng.randi_range(1,20)
			num = 19
			if num > 18:
				Powerups.choose_powerup(self)
				return true
	return false
					
func update_current_player(var value):
	$CurrentPlayer.visible = value
	$Gun/ArcParticle.visible = value

func get_current_weapon():
	return current_weapon

func set_current_weapon(var value):
	current_weapon = value

#decides which weapon is called based on the current_weapon value
func shoot():
	match current_weapon:
		0:
			gun.shoot_default()
			$SoundShootCannon.play()
		1:
			gun.shoot_cluster()
			$SoundShootCluster.play()
		2:
			gun.shoot_laser()
			$SoundShootLaser.play()
		3:
			gun.shoot_mine()
			$SoundShootMine.play()
		4:
			gun.shoot_flame()
			$SoundShootFlamethrower.play()

# Damage calculations
func take_damage(amount):
	if powerup == 2 and amount > 0: # Shield
		amount = amount / 2
		
	hp -= amount
	update_hp()
	$SoundPlayerTakeDamage.play()
	if hp <= 0 and !dead:
		die()
		$SoundPlayerDedz.play()

func die():
	dead = true
	# Animations, score changes go here.
	visible = false # Currently does not stop or restart the game
	collision_mask = 0b0 # Stops bullets from hitting
	emit_signal("death") # Sent to PlayerController object to tally death count


func _on_RigidBody2D_body_shape_entered(body_id, body, body_shape, local_shape):
	if str(body).begins_with("[Rigid"):
		touching = true


func _on_RigidBody2D_body_shape_exited(body_id, body, body_shape, local_shape):
	if str(body).begins_with("[Rigid"):
		touching = false

func change_tank_color(color):
	get_node("Gun/gun").texture = load("res://images/Tanks/TankBarrel" + str(color) + ".png")
	get_node("tank").texture = load("res://images/Tanks/symTank" + str(color) + ".png")
	tank_color = color
