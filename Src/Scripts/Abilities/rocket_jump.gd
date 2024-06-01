extends Node2D

@export var speed : float = 2 ##The amount of knockback generated from this ability
@export var downScale : float = 0.2 ##How much to shrink the player by when they use this ability
@export var minimumScale : float = 0.6 ##How much size is required to use this ability in the first place
@export_range(0, 100, 0.01, "suffix: %") var selfDamageProportion : float = 10 ##Percent of damage using this does to your health pool
@export_group("References")
@export var player : Player
@export var playerHealthNode : Health
@export var damageModule : Damager
@export var selfDamageModule : Damager
@export var blastArea : Area2D
@export var explosionParticles : GPUParticles2D
@export var explosionSound : AudioStreamPlayer2D

func _ready():
	speed *= 1000000
	selfDamageProportion = selfDamageProportion / 100
	
	Signal_bus.overcharged.connect(onOvercharge)
	Signal_bus.usedOvercharge.connect(offOvercharge)
	
	assert(player, "You have to assign the player to the Rocket Jump Node")

func _unhandled_input(event):
	if event.is_action_pressed("use_ability_2") and GlobalVars.scaleFactor >= 0.6:
		explode()

func explode():
	explosionSound.play()
	Signal_bus.shakeCam.emit(40, 5)
	explosionParticles.emitting = true
	
	applyVelocity()
	
	var bodies : Array = blastArea.get_overlapping_bodies()
	
	for body in bodies:
		if not body is Player:
			damageModule.dealDamage(body)
	
	Signal_bus.changeScaleFactor.emit(GlobalVars.scaleFactor - 0.2)
	#damagePlayer()
	

func onOvercharge():
	damageModule.critRate = 1

func offOvercharge():
	damageModule.critRate = 0

func applyVelocity():
	var vector := player.global_transform.origin - global_transform.origin
	var direction := vector.normalized()
	var distance := vector.length()
	
	var velocity := (direction * speed)/distance
	
	player.velocity += velocity

func damagePlayer():
	var damage : float = playerHealthNode.maxHealth * selfDamageProportion
	selfDamageModule.baseDamage = damage
	selfDamageModule.dealDamage(player)
