extends CharacterBody2D
class_name Player

@export var cameraTarget : Node2D
@export var margins : float = 400
@export var divider : float = 100
@export var transitionSpeed : float = 0.3

var timeMoving : float = 0

func _physics_process(delta):
	
	if velocity == Vector2.ZERO:
		timeMoving = 0
	else:
		timeMoving = clamp((timeMoving + delta) * transitionSpeed, 0, 1)
	
	
	cameraTarget.position.y = lerp(cameraTarget.position.y, velocity.y, timeMoving)
	
	#if abs(cameraTarget.position.x) > margins:
		#if cameraTarget.position.x > 0:
			#cameraTarget.position.x = margins
		#else:
			#cameraTarget.position.x = -margins
	#
	if abs(cameraTarget.position.y) > margins:
		if cameraTarget.position.y > 0:
			cameraTarget.position.y = margins
		else:
			cameraTarget.position.y = -margins
