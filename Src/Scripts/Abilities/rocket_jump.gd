extends Node2D

@export var speed : float = 2
@export_range(0, 100, 0.01, "suffix: %") var selfDamageProportion : float = 10 ##Percent of damage using this does to your health pool
@export_group("References")
@export var player : Player
@export var playerHealthNode : Health
@export var damageModule : Damager
@export var selfDamageModule : Damager
@export var blastArea : Area2D
@export var explosionParticles : GPUParticles2D

func _ready():
	speed *= 1000000
	selfDamageProportion = selfDamageProportion / 100
	
	Signal_bus.overcharged.connect(onOvercharge)
	Signal_bus.usedOvercharge.connect(offOvercharge)
	
	assert(player, "You have to assign the player to the Rocket Jump Node")

func _unhandled_input(event):
	if event.is_action_pressed("use_ability_2"):
		explode()

func explode():
	Signal_bus.shakeCam.emit(40, 5)
	explosionParticles.emitting = true
	
	applyVelocity()
	
	var bodies : Array = blastArea.get_overlapping_bodies()
	
	for body in bodies:
		if not body is Player:
			damageModule.dealDamage(body)
	
	damagePlayer()
	

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
	print(playerHealthNode.maxHealth)
	selfDamageModule.baseDamage = damage
	selfDamageModule.dealDamage(player)
