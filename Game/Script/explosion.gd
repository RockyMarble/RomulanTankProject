extends Area2D

var explosion_damage = 12
var explosion_life = 1

onready var timer := $Timer

#time for animation
func _ready():
	$Particles2D.emitting = true
	$SoundCannonExplosion.play()
	timer.start(explosion_life)

#searches the overlapping bodies for players to do damage calculation
func _process(_delta):
	if timer.is_stopped():
		explode()
		queue_free()

func explode():
	for body in get_overlapping_bodies():
		if body.is_in_group("Player"):
			body.take_damage(explosion_damage)
