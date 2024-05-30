extends Node2D
class_name Pickup

@export var increaseScaleFactor : float = 0.5 ##This determies by how much the slime will increase in size when picking up this item

func _on_area_2d_body_entered(body):
	if body is Player:
		body.scaleFactor += increaseScaleFactor
		queue_free()
