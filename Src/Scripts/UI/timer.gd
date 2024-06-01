extends Control

@export var minutesLabel : Label
@export var secondsLabel : Label
@export var mscLabel : Label

var time : float = 0.0
var minutes : int = 0
var seconds : int = 0
var msc : int = 0

func _process(delta):
	if get_tree().paused:
		return
	time += delta
	GlobalVars.timeSpent = time
	
	msc = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	
	minutesLabel.text = "%02d:" % minutes
	secondsLabel.text = "%02d." % seconds
	mscLabel.text = "%03d" % msc
	
	GlobalVars.timeSpent = time

func stop() -> void:
	set_process(false)

func get_time_formatted() -> String:
	return "%02d:%02d.%03d" % [minutes, seconds, msc]
