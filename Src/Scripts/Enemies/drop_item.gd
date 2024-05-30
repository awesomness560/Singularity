extends Node2D
class_name DropItem

@export var scoreOnKill : int = 30
@export var healthNode : Health ##This is optional if you are manually dropping an item (Doesn't rely on death)
@export var pickupScene : PackedScene

func _ready():
	if healthNode:
		healthNode.dead.connect(spawnPickup)
	
	assert(pickupScene, "You did not assign the pickup scene for the drop item node for the creature " + str(get_parent()))
		
func spawnPickup(destroyNodeOnDeath : bool = true):
	GlobalVars.enemyScore += scoreOnKill
	
	var pickup : Pickup = pickupScene.instantiate()
	get_tree().current_scene.add_child(pickup)
	pickup.global_position = global_position
	
	if destroyNodeOnDeath:
		get_parent().queue_free()
		Signal_bus.shakeCam.emit(20, 5)
