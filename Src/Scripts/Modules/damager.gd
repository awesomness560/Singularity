extends Node
class_name Damager

@export_category("Settings")
@export var baseDamage = 20
@export_range(0, 100, 0.1, "suffix: %") var critRate : float
@export_range(1, 1000, 0.1, "suffix: x") var critMultiplier : float
@export_range(1, 1000, 0.1, "suffix: x") var stunMultiplier : float = 1##How much extra damage this should do when the enemy is stunned

var healthModule : Health
var currentDamage

func config():
	critRate = critRate / 100

func dealDamage(body):
	if is_instance_valid(body):
		healthModule = body.get_node_or_null("HealthModule")
	
	if healthModule:
		if isCrit():
			currentDamage = damageCalc(baseDamage, true)
			healthModule.lowerHealth(currentDamage, true)
		else:
			currentDamage = damageCalc(baseDamage)
			healthModule.lowerHealth(currentDamage)
			
	healthModule = null

func isCrit() -> bool:
	if critRate > randf():
		return true
	else:
		return false

func damageCalc(damage, crit : bool = false, stunMulti : float = 1) -> float:
	if crit:
		damage *= critMultiplier
	return damage
