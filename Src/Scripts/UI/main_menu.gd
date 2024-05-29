extends CanvasLayer


func _on_start_game_pressed():
	var sceneManager : SceneManager = GlobalVars.sceneManager
	
	sceneManager.currentScene = self
	sceneManager.loadGame()
