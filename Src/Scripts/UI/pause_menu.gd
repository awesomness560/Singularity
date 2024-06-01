extends Control

@export var mainMenu : PackedScene

@export var pauseMenu : VBoxContainer
@export var settingsMenu : Control

@export var backButton : Button

var currentMenu : Control

func _unhandled_input(event):
	if event.is_action_pressed("go_back"):
		_on_back_button_pressed()

func _on_resume_pressed():
	get_tree().paused = false
	hide()


func _on_settings_pressed():
	currentMenu = settingsMenu
	settingsMenu.show()
	pauseMenu.hide()
	backButton.show()


func _on_back_button_pressed():
	if currentMenu: 
		currentMenu.hide()
	
	backButton.hide()
	currentMenu = null
	pauseMenu.show()


func _on_main_menu_pressed():
	if GlobalVars.sceneManager:
		GlobalVars.sceneManager.purgeAndSwitch(mainMenu)
