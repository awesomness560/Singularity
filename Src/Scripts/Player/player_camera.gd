extends Camera2D
class_name PlayerCamera

@export var movementSpeed : float = 200 ##How fast the camera moves across the screen (side scrolling)
@export var onSideSpeed : float = 1000 ##This is how fast the camera moves when the player wants to push it faster

var camTarget : Node2D ##The parent that the camera inherits the y value from

var currentMovementSpeed : float = 0

func _ready():
	camTarget = get_parent()
	currentMovementSpeed = movementSpeed

func _process(delta):
	global_position.x += currentMovementSpeed * delta
	#We are set to top level so we ingore the transform of our parent. We need to set the y transform to be the same though
	global_position.y = camTarget.global_position.y 


func _on_area_2d_area_entered(area): ##Make the camera move faster when the player is near the edge
	if area is Player:
		currentMovementSpeed = onSideSpeed


func _on_area_2d_area_exited(area):
	if area is Player:
		currentMovementSpeed = movementSpeed
