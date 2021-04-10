extends Node2D

export var muzzle_velocity = 1000
export var bullet_gravity = 750
onready var smoke_particle := $SmokeParticle

var laser_damage = 10

onready var laser_raycast := $LaserRaycast
onready var laser_sprite := $laser
onready var laser_timer := $LaserTimer
onready var laser_particle := $LaserParticle

func _process(delta):
	rotation_degrees = clamp(rotation_degrees, -180, 0)
	if laser_timer.is_stopped():
		laser_sprite.visible = false

#adds a default projectile with a certain velocity
func shoot_default():
	var b = load("res://scenes/bullet.tscn").instance()
	owner.get_parent().add_child(b)
	b.global_transform = $GunBarrel.global_transform
	b.velocity = b.transform.x * muzzle_velocity
	b.bullet_gravity = bullet_gravity
	gun_smoke()
	
#adds a cluster projectile with certain velocity
func shoot_cluster():
	var b = load("res://scenes/cluster.tscn").instance()
	owner.get_parent().add_child(b)
	b.global_transform = $GunBarrel.global_transform
	b.velocity = b.transform.x * muzzle_velocity
	b.bullet_gravity = bullet_gravity
	gun_smoke()

func gun_smoke():
	smoke_particle.emitting = true

func shoot_laser():
	laser_particle.emitting = true
	laser_sprite.visible = true
	laser_timer.start()
	laser_raycast.force_raycast_update()
	var body = laser_raycast.get_collider()
	if body != null and body.is_in_group("Player"):
		body.take_damage(laser_damage)
