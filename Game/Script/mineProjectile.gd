extends Area2D

var velocity = Vector2(0, 0)
var bullet_gravity = 250
var bullet_damage = 5

var mine = preload("res://scenes/mine.tscn")
var explosion = preload("res://scenes/clusterExplosion.tscn")

#Sets the velocity of the projectile with adding gravity
#changes the angle that the projectile is traveling to
func _process(delta):
	velocity.y += bullet_gravity * delta
	position += velocity * delta
	rotation += .25


func _on_mineProjectile_body_entered(body):
	velocity.x = 0
	velocity.y = 0
	bullet_gravity = 0
	
	if body.is_in_group("Player"):
		var explosion_instance = explosion.instance()
		explosion_instance.position = self.position
		get_parent().add_child(explosion_instance)
		queue_free()
		return
	
	var mine_instance= mine.instance()
	mine_instance.position = self.position
	get_parent().add_child(mine_instance)
	queue_free()
