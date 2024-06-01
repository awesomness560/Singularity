extends Camera2D
class_name PlayerCamera

@export var lockOnPlayer : bool = false
@export var movementSpeed : float = 200 ##How fast the camera moves across the screen (side scrolling)
@export var onSideSpeed : float = 1000 ##This is how fast the camera moves when the player wants to push it faster

@export var randomStrength : float = 30
@export var shakeFade : float = 5.0

var rng = RandomNumberGenerator.new()

var camTarget : Node2D ##The parent that the camera inherits the y value from

var currentMovementSpeed : float = 0
var shake_strength : float = 0

func _ready():
	camTarget = get_parent()
	currentMovementSpeed = movementSpeed
	
	Signal_bus.shakeCam.connect(signalShake)
	Signal_bus.lockOntoPlayer.connect(lockUntoPlayer)

func _process(delta):
	if not lockOnPlayer:
		top_level = true
		global_position.x += currentMovementSpeed * delta
		#We are set to top level so we ingore the transform of our parent. We need to set the y transform to be the same though
		global_position.y = camTarget.global_position.y
	else:
		top_level = false
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		
		offset = randomOffset()

#Shake functions
func signalShake(strength : float = 20, fade : float = 5):
	randomStrength = strength
	shakeFade = fade
	applyShake()

func lockUntoPlayer():
	lockOnPlayer = true

func applyShake():
	shake_strength = randomStrength

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))


func _on_area_2d_area_entered(area): ##Make the camera move faster when the player is near the edge
	if area is Player:
		currentMovementSpeed = onSideSpeed


func _on_area_2d_area_exited(area):
	if area is Player:
		currentMovementSpeed = movementSpeed
