extends Node

@export var energyBar : HealthBar
@export var regenTimer : Timer
@export var maxEnergy : float = 100
@export var regenValue : float = 20

var isRegenerating : bool = false

var currentEnergy : float

func _ready():
	currentEnergy = maxEnergy
	GlobalVars.playerEnergy = currentEnergy
	regenTimer.timeout.connect(_on_regen_time_timeout)
	
	if energyBar:
		energyBar.init_health(maxEnergy)

func _process(delta):
	var prevEnergy := currentEnergy
	
	if currentEnergy != GlobalVars.playerEnergy:
		currentEnergy = GlobalVars.playerEnergy
		energyBar._set_health(currentEnergy)
	
	if currentEnergy < prevEnergy:
		regenTimer.start()
	
	if isRegenerating:
		currentEnergy += regenValue * delta
		GlobalVars.playerEnergy = currentEnergy
		energyBar._set_health(currentEnergy)

func _on_regen_time_timeout():
	isRegenerating = true
