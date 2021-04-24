extends RigidBody2D

var explosion = preload("res://scenes/explosion.tscn")

onready var arming_timer := $ArmingTimer

func _ready():
	arming_timer.start()
	$SoundMineArm.play()

func _process(_delta):
	if !sleeping and arming_timer.is_stopped():
		explode()

func explode():
	var explosion_instance = explosion.instance()
	explosion_instance.position = self.position
	explosion_instance.explosion_damage = 22
	get_parent().add_child(explosion_instance)
	queue_free()
