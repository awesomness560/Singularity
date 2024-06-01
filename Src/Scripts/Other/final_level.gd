extends Node2D

@export var numOfEnemies : int = 11
@export var animationPlayer : AnimationPlayer

var currentEnemiesDead : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Signal_bus.lockOntoPlayer.emit()
	Signal_bus.enemyDied.connect(onEnemyDeath)
	Signal_bus.enemySpawned.connect(newEnemy)
	
	animationPlayer.play("objective")

func newEnemy():
	numOfEnemies += 1

func onEnemyDeath():
	currentEnemiesDead += 1
	
	if currentEnemiesDead >= numOfEnemies:
		Signal_bus.gameCompleted.emit()
