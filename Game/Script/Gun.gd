extends Node2D

export var muzzle_velocity = 1000
export var bullet_gravity = 750

var laser_damage = 12
var flame_damage = 30

onready var laser_raycast  := $LaserRaycast
onready var laser_sprite   := $laser
onready var laser_timer    := $LaserTimer
onready var laser_particle := $LaserParticle
onready var smoke_particle := $SmokeParticle
onready var flame_area     := $FlameArea
onready var flame_particle := $FlameParticle
onready var laser_dust     := $LaserDust
onready var arc            := $ArcParticle
onready var arc_timer       := $ArcTimer

func _process(_delta):
	rotation_degrees = clamp(rotation_degrees, -180, 0)
	if laser_timer.is_stopped():
		laser_sprite.visible = false
	if arc_timer.is_stopped(): #after timer done, makes arc visible again
		arc.visible          = true

#adds a default projectile with a certain velocity
func shoot_default():
	arc_after_shot()
	var b = load("res://scenes/bullet.tscn").instance()
	owner.get_parent().add_child(b)
	b.global_transform = $GunBarrel.global_transform
	b.velocity         = b.transform.x * muzzle_velocity
	b.bullet_gravity   = bullet_gravity
	gun_smoke()
	
#adds a cluster projectile with certain velocity
func shoot_cluster():
	arc_after_shot()
	var b = load("res://scenes/cluster.tscn").instance()
	owner.get_parent().add_child(b)
	b.global_transform = $GunBarrel.global_transform
	b.velocity         = b.transform.x * muzzle_velocity
	b.bullet_gravity   = bullet_gravity
	gun_smoke()

#shoots a raycast and damages the first body hit
func shoot_laser():
	arc_after_shot()
	laser_particle.emitting = true
	laser_sprite.visible    = true
	laser_dust.emitting     = true
	
	laser_timer.start()
	laser_raycast.force_raycast_update()
	var body = laser_raycast.get_collider()
	if body != null and body.is_in_group("Player"):
		body.take_damage(laser_damage)

#shoots a mine that if it doesnt hit a player, will arm after 1 second
func shoot_mine():
	arc_after_shot()
	var b = load("res://scenes/mineProjectile.tscn").instance()
	owner.get_parent().add_child(b)
	b.global_transform = $GunBarrel.global_transform
	b.velocity         = b.transform.x * muzzle_velocity
	b.bullet_gravity   = bullet_gravity
	gun_smoke()

func shoot_flame():
	arc_after_shot()
	flame_particle.emitting = true
	for body in flame_area.get_overlapping_bodies():
		if body.is_in_group("Player"):
			body.take_damage(flame_damage)

func gun_smoke():
	smoke_particle.emitting = true

#turns off the arc line once shot is made. doesnt actually follow timer
#as usually switching character before timer is over
func arc_after_shot():
	arc_timer.start()
	arc.visible = false
	
