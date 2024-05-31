extends Node

@export var maxEnergy : float = 100
@export var regenValue : float = 20

@export_group("References")
@export var energyBar : HealthBar
@export var regenTimer : Timer
@export var energyLabel : ScoreLabel

var isRegenerating : bool = false

var currentEnergy : float

func _ready():
	currentEnergy = maxEnergy
	GlobalVars.maxPlayerEnergy = maxEnergy
	GlobalVars.playerEnergy = currentEnergy
	
	regenTimer.timeout.connect(_on_regen_time_timeout)
	
	if energyLabel:
		energyLabel.initScore(currentEnergy)
		energyLabel.lerpStep = 0.08
	
	if energyBar:
		energyBar.init_health(maxEnergy)

func _process(delta):
	var prevEnergy := currentEnergy
	
	if currentEnergy != GlobalVars.playerEnergy:
		currentEnergy = GlobalVars.playerEnergy
		energyBar._set_health(currentEnergy)
	
	if currentEnergy < prevEnergy:
		isRegenerating = false
		regenTimer.start()
	
	if isRegenerating and not Input.is_action_pressed("use_ability_1"): #HACK: This is a bandaid fix to you regenerating while attempting to fire an ability
		currentEnergy += regenValue * delta
		GlobalVars.playerEnergy = currentEnergy
		energyBar._set_health(currentEnergy)
	
	if energyLabel:
		energyLabel.score_event(currentEnergy, true, false)

func _on_regen_time_timeout():
	isRegenerating = true
