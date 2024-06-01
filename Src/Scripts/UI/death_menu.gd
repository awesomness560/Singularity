extends Control

@export var men : PackedScene
@export var leaderboardID : String = "singularityslime-highest-score-KgBl"
@export_group("References")

@export var deathControl : Control
@export var finishControl : Control

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
	Signal_bus.gameCompleted.connect(onFinish)

func _on_visibility_changed():
	if visible:
		#TODO: Need to add a score based on the time taken
		#enemyScoreLabel.text = "Enemy score: " + str(GlobalVars.enemyScore)
		#sizeScoreLabel.text = "Size score: " + str(GlobalVars.sizeScore)
		#totalScoreLabel.text = "Total score: " + str(GlobalVars.sizeScore + GlobalVars.enemyScore)
		await get_tree().create_timer(0.5).timeout
		enemyScoreCounter.score_event(GlobalVars.enemyScore)
		sizeScoreCounter.score_event(GlobalVars.sizeScore)
		var totalScore = GlobalVars.sizeScore + GlobalVars.enemyScore
		totalScoreCounter.score_event(totalScore)
		
		var nickname : String
		if not GlobalVars.playerUsername:
			nickname = "NoUsername" + str(randi_range(100, 999))
		else:
			nickname = GlobalVars.playerUsername
		
		await Leaderboards.post_guest_score(leaderboardID, totalScore, nickname)

func onFinish():
	deathControl.hide()
	finishControl.show()
	show()

func _on_restart_pressed():
	var sceneManager : SceneManager = GlobalVars.sceneManager
	sceneManager.currentScene = get_parent().get_parent()
	sceneManager.purgeAndSwitch(men)
	get_tree().paused = false
