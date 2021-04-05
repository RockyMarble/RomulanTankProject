extends RigidBody2D


var left_vector = Vector2(-30, 0)
var right_vector = Vector2(30, 0)
var hp = 100
var current_weapon = 0

var flipping = false
var dead = false

onready var gun := $Gun

func _integrate_forces(state):
	keep_upright()

func _physics_process(delta):
	linear_velocity.x = clamp(linear_velocity.x, -100, 100)


func move_left():
	apply_central_impulse(left_vector)

func move_right():
	apply_central_impulse(right_vector)

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

func update_current_player(var value):
	$CurrentPlayer.visible = value

func get_current_weapon():
	return current_weapon

func set_current_weapon(var value):
	current_weapon = value

#decides which weapon is called based on the current_weapon value
func shoot():
	match current_weapon:
		0:
			gun.shoot_default()
		1:
			gun.shoot_cluster()

#damage calculations
func take_damage(amount):
	hp -= amount
	update_hp()
	$SoundPlayerTakeDamage.play()
	if hp <= 0:
		dead = true
		print("Dead") # debug
		# Animations, score changes go here.
		visible = false # Currently does not stop or restart the game
		$SoundPlayerDedz.play()

