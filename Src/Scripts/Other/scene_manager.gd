extends Node2D
class_name SceneManager

@export var mainGame : PackedScene
var currentScene

func _ready():
	GlobalVars.sceneManager = self

func loadGame():
	switchScene(currentScene, mainGame)

func purgeAndSwitch(newScene : PackedScene):
	for i in get_children():
		if is_instance_valid(i):
			i.queue_free()
	
	var scene = newScene.instantiate()
	add_child(scene)

func switchScene(prevScene, newScene : PackedScene):
	print("Switch")
	prevScene.queue_free()
	
	var scene = newScene.instantiate()
	add_child(scene)
