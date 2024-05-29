extends Node2D
class_name AbilityManager

@export var aimRotator : Node2D

func _process(delta):
	aimRotator.look_at(get_global_mouse_position())

func addAbility(scene : PackedScene, childOfAim : bool = true):
	var ability = scene.instantiate()
	
	if childOfAim:
		aimRotator.get_child(0).add_child(ability) #HACK: Using get_child here. Try not to move the hierachy for the ability manager
	else:
		add_child(ability)
