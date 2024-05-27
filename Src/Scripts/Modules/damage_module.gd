
extends Node
class_name DamageModule

#The amount here should be negative if we want to do damage
#This is so we can easily make items that heal by passing in a positive value
#To the deal damage function
func dealDamage(amount : float, node : Node):
	var healthModule : HealthModule = node.get_node_or_null("Health")
	
	#This code will only run if the node we are looking at has a health module to begin with
	#This is so any node interacting with the damage node can just pass in any node it touches (If that is how it deals damage)
	#Without having to worry if it can damage it
	if healthModule:
		healthModule.changeHealth(amount)
