extends Node
class_name Health

signal dead

@export var maxHealth : int = 100 ##The maximum health of this object
@export var isInvulnerable : bool = false
@export_group("References")
@export var healthBar : HealthBar
@export var damageNumberOrigin : Node2D ##A Node2d containing the position of where the damage numbers should spawn (PLEASE SET)
@export var healthLab : ScoreLabel ##The health label
@export var hurtSound : AudioStreamPlayer
var health : float #The current health of the object

func _ready():
	health = maxHealth #Setting the current health to the max health
	
	if healthLab:
		healthLab.initScore(maxHealth)
		healthLab.lerpStep = 0.05
	#healthLab.initScore(health)
	if healthBar:
		healthBar.init_health(maxHealth)
	
	if not damageNumberOrigin:
		printerr("Warning: You did not set a damage number origin for the health module on the node " + str(get_parent()))

func lowerHealth(damage : float, isCrit : bool = false):
	if !isInvulnerable:
		health -= damage #Reduces current health by specfied amount
		if hurtSound:
			hurtSound.play()
		
		setHealth(health)
		if damageNumberOrigin:
			if isCrit:
				DamageNumbers.displayNumber(damage, damageNumberOrigin.global_position, true)
			else:
				DamageNumbers.displayNumber(damage, damageNumberOrigin.global_position)
		if healthBar:
			healthBar._set_health(health)
		if(health <= 0): #Checks if the health is less than zero
			dead.emit() #Sends a signal saying that this object is dead
			health = 0 #Changes to health to zero to prevent negative health

func increaseHealth(heal : float):
	health += heal #Increases current health by heal amount
	setHealth(health)
	if healthBar:
		healthBar.health = health
	if health > maxHealth: #Checks if the heal makes the health go over max health
		health = maxHealth #If that is the case, then it will set the current health exactly equal to max health

func changeMaxHealth(change : int): #Changes the max health
	maxHealth = change

func setHealth(healthAmount : float):
	health = healthAmount
	
	if healthLab:
		healthLab.score_event(healthAmount, true)
