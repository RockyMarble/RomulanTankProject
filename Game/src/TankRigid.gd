extends RigidBody2D

var left_vector = Vector2(-30, 0)
var right_vector = Vector2(30, 0)

var flipping = false

onready var particle := $tank/Particles2D

func _integrate_forces(state):
	keep_upright()

func _process(delta):
	emit_particle()

func _physics_process(delta):
	linear_velocity.x = clamp(linear_velocity.x, -100, 100)


func move_left():
	apply_central_impulse(left_vector)

func move_right():
	apply_central_impulse(right_vector)

func emit_particle():
	if linear_velocity.x > 20 or linear_velocity.x < -20:
		particle.emitting = true
	else:
		particle.emitting = false

func keep_upright():
	if rotation_degrees < -25:
		apply_torque_impulse(850)
	if rotation_degrees > 25:
		apply_torque_impulse(-850)

func rotate_left():
	$Gun.rotation_degrees -= 1

func rotate_right():
	$Gun.rotation_degrees += 1
