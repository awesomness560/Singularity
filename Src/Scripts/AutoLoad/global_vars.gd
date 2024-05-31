extends Node

var sceneManager : SceneManager

var timeSpent : float

var enemyScore : int
var timeScore : float
var sizeScore : int

var playerEnergy : float : set = keepPositiveEnergy #HACK: This is not the most modular way to do this, but it is the fastest


func keepPositiveEnergy(energy : float):
	if energy < 0:
		energy = 0
	
	playerEnergy = energy
