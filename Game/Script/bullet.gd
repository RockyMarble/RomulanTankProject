extends Area2D

var velocity = Vector2(0, 0)
var bullet_gravity = 250
var bullet_damage = 10

var explosion = preload("res://scenes/explosion.tscn")

#Sets the velocity of the projectile with adding gravity
#changes the angle that the projectile is traveling to
func _process(delta):
	velocity.y += bullet_gravity * delta
	position += velocity * delta
	rotation = velocity.angle()

#on hitting an object, it stops and calculates damage
#Then explodes and removes itself
func _on_bullet_body_entered(body):
	velocity.x = 0
	velocity.y = 0
	bullet_gravity = 0
	
	if body.is_in_group("Player"):
		body.take_damage(bullet_damage)
	call_deferred("explode")
	queue_free()
	
func explode():
	var explosion_instance = explosion.instance()
	explosion_instance.position = self.position
	get_parent().add_child(explosion_instance)
