extends Control

@export var men : PackedScene
@export var enemyScoreLabel : Label
@export var sizeScoreLabel : Label

func _ready():
	print(men)

func _on_visibility_changed():
	if visible:
		#TODO: Need to add a score based on the time taken
		enemyScoreLabel.text = "Enemy score: " + str(GlobalVars.enemyScore)
		sizeScoreLabel.text = "Size score: " + str(GlobalVars.sizeScore)


func _on_restart_pressed():
	var sceneManager : SceneManager = GlobalVars.sceneManager
	sceneManager.currentScene = get_parent().get_parent()
	sceneManager.purgeAndSwitch(men)
	get_tree().paused = false
