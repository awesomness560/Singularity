extends Area2D

var particleType = "Quark"
var size = randf_range(1,2)

func _ready():
	apply_scale(Vector2(size,size))
