extends ShapeCast2D
class_name LaserAbility


var tween : Tween = Tween.new()

var isCasting := false : set = set_is_casting
@export var beamSize : float = 10
@export var energyConsumptionRate : float = 50


var collisionBody
var isFiring : bool = false
var initalShot : bool = true
var onCooldown : bool = false
var isOvercharged : bool = false : set = setOvercharge

@onready var originalCritRate : float = damageNode.critRate / 100

@export_group("References")
@export var castingParticles : GPUParticles2D
@export var collisionParticles : GPUParticles2D
@export var beamParticles : GPUParticles2D
@export var line2d : Line2D
@export var damageNode : Damager

@export_category("Timers")
@export var damageRate : Timer
@export var cooldownTimer : Timer
@export var maxActivationTimer : Timer
@export var activationTimer : Timer

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO #Makes the line disappear
	
	cooldownTimer.start()
	Signal_bus.overcharged.connect(overcharge)
	Signal_bus.usedOvercharge.connect(notOvercharged)

func _unhandled_input(event):
	if event.is_action_pressed("use_ability_1"):
		#_on_auto_activation_time_timeout()
		isCasting = true
	else:
		if event.is_action_released("use_ability_1"):
			isCasting = false

func _physics_process(delta):
	#if GlobalVars.playerEnergy <= 0:
		#isCasting = false
	
	var castPoint := target_position
	force_shapecast_update()
	
	$CollisionParticles.emitting = is_colliding()
	
	if is_colliding():
		castPoint = to_local(get_collision_point(0))
		$CollisionParticles.global_rotation = get_collision_normal(0).angle()
		$CollisionParticles.position = castPoint
		#Camera.applyShake(5, 10)
		if get_collider(0) is RigidBody2D or get_collider(0) is CharacterBody2D:
			collisionBody = get_collider(0)
			isFiring = true
		else:
			collisionBody = null
			isFiring = false
	
	$Line2D.points[1] = castPoint
	$BeamParticles.position = castPoint * 0.5
	$BeamParticles.process_material.emission_box_extents.x = castPoint.length() * 0.5
	
	if isFiring and initalShot:
		damageRate.start()
		damageNode.dealDamage(collisionBody)
		initalShot = false
	
	GlobalVars.playerEnergy -= energyConsumptionRate * delta
	
func set_is_casting(cast : bool):
	isCasting = cast
	if onCooldown:
		isCasting = false
		cooldownTimer.start()
	
	$BeamParticles.emitting = isCasting
	$CastingParticles.emitting = isCasting
	if isCasting:
		appear()
	else:
		disappear()
		$CollisionParticles.emitting = false
		isFiring = false
		initalShot = true
		damageRate.stop()
		#new_shape.process_mode = Node.PROCESS_MODE_DISABLED
	set_physics_process(isCasting)
	
func setOvercharge(status : bool):
	isOvercharged = status
	
	if status:
		damageNode.critRate = 1
	else:
		damageNode.critRate = originalCritRate

func overcharge():
	isOvercharged = true

func notOvercharged():
	isOvercharged = false

func appear():
	tween.kill()
	tween = create_tween()
	tween.tween_property($Line2D, "width", beamSize, 0.2)
	#Camera.applyShake(10, 4)

func disappear():
	tween.kill()
	tween = create_tween()
	tween.tween_property($Line2D, "width", 0, 0.1)#.set_ease(Tween.EASE_OUT)
	


func _on_damage_rate_timeout():
	if collisionBody:
		damageNode.dealDamage(collisionBody)


#func _on_cooldown_timeout():
	#onCooldown = false
	#activationTimer.start()
	#$CastingParticles.emitting = true
#
#func enterCooldown():
	#isCasting = false
	#onCooldown = true
	#cooldownTimer.start()
#
#func _on_max_activation_time_timeout():
	#isCasting = false
	#onCooldown = true
	#cooldownTimer.start()
	#
	#isOvercharged = false
#
#
#func _on_auto_activation_time_timeout():
	#isCasting = true
	#maxActivationTimer.start()

#func levelUp(): ##Must Implement
	#var upgradeResource : LaserResource = levels[level - 1]
	#initalStats = upgradeResource
	#
	#level += 1
	#configureToResource()
	#print("Leveled up: " + str(level))

#func getResource() -> BaseAbility: ##must implement
	#return levels[level - 1]

#func isMaxLevel() -> bool: ##
	#if level - 1 >= levels.size():
		#return true
	#else:
		#return false
