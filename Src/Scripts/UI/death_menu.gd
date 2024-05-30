extends Control

@export var enemyScoreLabel : Label
@export var sizeScoreLabel : Label

func _on_visibility_changed():
	if visible:
		#TODO: Need to add a score based on the time taken
		enemyScoreLabel.text = "Enemy score: " + str(GlobalVars.enemyScore)
		sizeScoreLabel.text = "Size score: " + str(GlobalVars.sizeScore)
