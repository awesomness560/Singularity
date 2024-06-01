extends Node

var sceneManager : SceneManager

var timeSpent : float
var scaleFactor : float

var enemyScore : int
var timeScore : float
var sizeScore : int

var playerEnergy : float : set = keepPositiveEnergy #HACK: This is not the most modular way to do this, but it is the fastest
var maxPlayerEnergy : float

func keepPositiveEnergy(energy : float):
	playerEnergy = clampf(energy, 0, maxPlayerEnergy)
