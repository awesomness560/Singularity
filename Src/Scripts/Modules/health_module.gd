extends Node
class_name HealthModule

var currentHealth : float

@export var maxHealth : float = 100

func _ready():
	currentHealth = maxHealth

#I put this in a function so that we can add other effects when we want to change health
#Like particles or changing a healthbar
#Makes adding new things easier
func changeHealth(amount : float):
	currentHealth += amount
	
	if currentHealth > maxHealth: #Making sure we don't go over the max health
		currentHealth = maxHealth
