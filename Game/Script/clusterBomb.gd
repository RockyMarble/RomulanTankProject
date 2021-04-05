extends RigidBody2D

onready var timer := $Timer

var rng = RandomNumberGenerator.new()
var time_explode
var explosion = preload("res://scenes/clusterExplosion.tscn")

#sets the time it takes before the bomb explodes
func _ready():
	rng.randomize()
	time_explode = rng.randf_range(1, 1.5)
	timer.start(time_explode)

#spawns an explosion hitbox
func _process(delta):
	if timer.is_stopped():
		var explosion_instance = explosion.instance()
		explosion_instance.position = self.position
		get_parent().add_child(explosion_instance)
		queue_free()
