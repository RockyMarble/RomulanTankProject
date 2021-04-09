extends Area2D

var velocity = Vector2(0, 0)
var bullet_gravity = 250
var rng = RandomNumberGenerator.new()

var bomb = preload("res://scenes/clusterBomb.tscn")

func _ready():
	rng.randomize()

#Sets the velocity of the projectile with adding gravity
#changes the angle that the projectile is traveling to
func _process(delta):
	velocity.y += bullet_gravity * delta
	position += velocity * delta
	rotation = velocity.angle()


#on hitting an object, it spawns bombs that are applied a random force between an interval
func _on_Node2D_body_entered(body):
	velocity.x = 0
	velocity.y = 0
	bullet_gravity = 0
	$SoundClusterPop.play()
	var counter = 5
	while (counter > 0):
		spawn_bomb()
		counter -= 1
	
	queue_free()

func spawn_bomb():
	var angle = Vector2()
	angle.x = rng.randf_range(-150, 150)
	angle.y = rng.randf_range(-300, -200)
	var bomb_instance = bomb.instance()
	bomb_instance.position = self.position
	get_parent().add_child(bomb_instance)
	bomb_instance.apply_central_impulse(angle)
