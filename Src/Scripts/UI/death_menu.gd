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

@export_subgroup("Time Score")
@export var timeContainer : HBoxContainer
@export var timeScoreLabel : Label
@export var timeScoreCounter : ScoreLabel

@export_subgroup("Total Score")
@export var totalScoreLabel : Label
@export var totalScoreCounter : ScoreLabel

var isFinished : bool = false

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
		
		if isFinished:
			var timeScore : float = 15000 / GlobalVars.timeSpent
			GlobalVars.timeScore = timeScore
			totalScore += 15000 / GlobalVars.timeSpent
			
			timeContainer.show()
			timeScoreCounter.score_event(timeScore)
		
		totalScoreCounter.score_event(totalScore)
		
		var nickname : String
		if not GlobalVars.playerUsername:
			nickname = "NoUsername" + str(randi_range(100, 999))
		else:
			nickname = GlobalVars.playerUsername
		
		totalScore = roundi(totalScore)
		
		var metadata : Dictionary = {"Enemy score" : GlobalVars.enemyScore, "Size Score" : GlobalVars.sizeScore, "Time score" : GlobalVars.timeScore, "Time spent" : GlobalVars.timeSpent}
		
		await Leaderboards.post_guest_score(leaderboardID, totalScore, nickname, metadata)
		
		GlobalVars.sizeScore = 0
		GlobalVars.timeScore = 0
		GlobalVars.enemyScore = 0

func onFinish():
	deathControl.hide()
	finishControl.show()
	show()
	isFinished = true
	get_tree().paused = true

func _on_restart_pressed():
	var sceneManager : SceneManager = GlobalVars.sceneManager
	sceneManager.currentScene = get_parent().get_parent()
	sceneManager.purgeAndSwitch(men)
	get_tree().paused = false
