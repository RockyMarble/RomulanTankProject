extends Area2D

var velocity = Vector2(0, 0)
var bullet_gravity = 250
var bullet_damage = 10

func _process(delta):
	velocity.y += bullet_gravity * delta
	position += velocity * delta
	rotation = velocity.angle()


func _on_bullet_body_entered(body):
	queue_free()
