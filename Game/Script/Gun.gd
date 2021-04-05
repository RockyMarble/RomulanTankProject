extends Node2D

export var muzzle_velocity = 600
export var bullet_gravity = 750

func _process(delta):
	rotation_degrees = clamp(rotation_degrees, -180, 0)

#adds a default projectile with a certain velocity
func shoot_default():
	var b = load("res://scenes/bullet.tscn").instance()
	owner.get_parent().add_child(b)
	b.global_transform = $GunBarrel.global_transform
	b.velocity = b.transform.x * muzzle_velocity
	b.bullet_gravity = bullet_gravity

#adds a cluster projectile with certain velocity
func shoot_cluster():
	var b = load("res://scenes/cluster.tscn").instance()
	owner.get_parent().add_child(b)
	b.global_transform = $GunBarrel.global_transform
	b.velocity = b.transform.x * muzzle_velocity
	b.bullet_gravity = bullet_gravity
