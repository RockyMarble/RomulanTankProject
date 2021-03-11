extends KinematicBody2D

const FLOOR_NORMAL = Vector2.UP
const SNAP_DIRECTION = Vector2.DOWN
const SNAP_LENGTH = 32.0
const FLOOR_MAX_ANGLE = deg2rad(46)

export (int) var speed = 82
export (int) var gravity = 200
var velocity = Vector2.ZERO
var snap_vector = SNAP_DIRECTION * SNAP_LENGTH

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed

func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	velocity.y = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, true, 4, FLOOR_MAX_ANGLE).y
