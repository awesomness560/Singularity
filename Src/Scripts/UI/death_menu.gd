extends Control

@export var men : PackedScene
@export_group("References")

@export_subgroup("Enemy Score")
@export var enemyScoreLabel : Label
@export var enemyScoreCounter : ScoreLabel

@export_subgroup("Size Score")
@export var sizeScoreLabel : Label
@export var sizeScoreCounter : ScoreLabel

@export_subgroup("Total Score")
@export var totalScoreLabel : Label
@export var totalScoreCounter : ScoreLabel

func _ready():
	print(men)

func _on_visibility_changed():
	if visible:
		#TODO: Need to add a score based on the time taken
		#enemyScoreLabel.text = "Enemy score: " + str(GlobalVars.enemyScore)
		#sizeScoreLabel.text = "Size score: " + str(GlobalVars.sizeScore)
		#totalScoreLabel.text = "Total score: " + str(GlobalVars.sizeScore + GlobalVars.enemyScore)
		await get_tree().create_timer(0.5).timeout
		enemyScoreCounter.score_event(GlobalVars.enemyScore)
		sizeScoreCounter.score_event(GlobalVars.sizeScore)


func _on_restart_pressed():
	var sceneManager : SceneManager = GlobalVars.sceneManager
	sceneManager.currentScene = get_parent().get_parent()
	sceneManager.purgeAndSwitch(men)
	get_tree().paused = false
