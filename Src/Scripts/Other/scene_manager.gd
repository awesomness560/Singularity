extends Node2D
class_name SceneManager

@export var mainGame : PackedScene
@export var finalLevel : PackedScene
var currentScene

func _ready():
	GlobalVars.sceneManager = self
	Signal_bus.reachedPortal.connect(switchToLast)

func loadGame():
	purgeAndSwitch(mainGame)

func switchToLast():
	for i in get_children():
		if is_instance_valid(i) and not i is Player:
			i.queue_free()
	
	var level = finalLevel.instantiate()
	add_child(level)

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
