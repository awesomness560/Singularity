extends CanvasLayer

@export var usernameLineEdit : LineEdit
@export var submitButton : Button
@export var submitTimer : Timer

func _on_start_game_pressed():
	var sceneManager : SceneManager = GlobalVars.sceneManager
	
	sceneManager.currentScene = self
	sceneManager.loadGame()


func _on_submit_pressed():
	GlobalVars.playerUsername = usernameLineEdit.text
	submitButton.text = "Submitted"
	submitTimer.start()


func _on_timer_timeout():
	submitButton.text = "Submit"
