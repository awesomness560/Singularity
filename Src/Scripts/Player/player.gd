extends CharacterBody2D
class_name Player

@export var margins : float = 400 ##How far the camera can go before being clamped
@export var transitionSpeed : float = 0.3 ##Speed of the camera
@export var scaleFactorMultiplier : float = 3

@export_group("References")
@export var cameraTarget : Node2D ##The camera target node
@export var collisionShape : CollisionShape2D
@export var scalableProperty : Node2D ##I set this to the sprite for now but if we want to scale more things this would be easier
@export var deathMenu : Control
@export var sprite : AnimatedSprite2D

@onready var originalSize : Vector2 = collisionShape.shape.size
@onready var originalScale : Vector2 = scalableProperty.scale

var timeMoving : float = 0
var scaleFactor : float = 1 : set = changeScaleFactor

var shaderMat : ShaderMaterial

func _ready():
	scaleFactor = 1 #To make sure that the setget runs (We don't have a size score of 0)
	shaderMat = sprite.material
	Signal_bus.usedOvercharge.connect(notOvercharged)

func _unhandled_input(event):
	if event.is_action_pressed("overcharge") and scaleFactor > 0.2:
		#TODO: Add in overcharge particle effects here
		scaleFactor -= 1
		Signal_bus.overcharged.emit()
		shaderMat.set_shader_parameter("on", true)
		Signal_bus.shakeCam.emit(30, 5)

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

func changeScaleFactor(newFactor : float):
	#FIXME: When scaling up the player, the arrow and laser should also scale up (maybe)
	scaleFactor = clampf(newFactor, 0.1, INF)
	GlobalVars.sizeScore = scaleFactor * scaleFactorMultiplier
	
	scalableProperty.scale = Vector2(originalScale.x * scaleFactor, originalScale.y * scaleFactor)
	
	var newShape : RectangleShape2D = collisionShape.shape
	newShape.size = Vector2(originalSize.x * scaleFactor, originalSize.y * scaleFactor)
	collisionShape.shape = newShape

func notOvercharged():
	shaderMat.set_shader_parameter("on", false)

func _on_health_dead():
	deathMenu.show()
	get_tree().paused = true
