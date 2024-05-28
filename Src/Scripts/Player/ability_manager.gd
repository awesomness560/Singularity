extends Node2D
class_name AbilityManager

@export var aimRotator : Node2D

func _process(delta):
	aimRotator.look_at(get_global_mouse_position())
