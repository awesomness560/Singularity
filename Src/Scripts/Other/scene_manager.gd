extends Node2D
class_name SceneManager

@export var mainGame : PackedScene
var currentScene

func _ready():
	GlobalVars.sceneManager = self

func loadGame():
	switchScene(currentScene, mainGame)

func switchScene(prevScene, newScene : PackedScene):
	prevScene.queue_free()
	
	var scene = newScene.instantiate()
	add_child(scene)
