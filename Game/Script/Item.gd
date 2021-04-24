extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Item_body_entered(body):
	if str(body).begins_with("[Rigid"):
		if body.powerup_check() == true:
			visible = false
			set_deferred("monitoring", false)

func _on_Item_area_entered(_area):
	visible = false
	set_deferred("monitoring", false)
