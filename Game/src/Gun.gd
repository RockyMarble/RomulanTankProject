extends Node2D

export var muzzle_velocity = 600
export var bullet_gravity = 750

func _process(delta):
	rotation_degrees = clamp(rotation_degrees, -180, 0)

func shoot():
	var b = load("res://Scene/bullet.tscn").instance()
	owner.get_parent().add_child(b)
	b.global_transform = $GunBarrel.global_transform
	b.velocity = b.transform.x * muzzle_velocity
	b.bullet_gravity = bullet_gravity
