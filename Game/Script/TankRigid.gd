extends RigidBody2D

var left_vector = Vector2(-30, 0)
var right_vector = Vector2(30, 0)

var flipping = false


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
