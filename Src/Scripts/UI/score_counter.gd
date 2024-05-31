extends Label
class_name ScoreLabel

var target_score = 0
var score = 0

var trauma = 0
var counter_offset = Vector2(0, 0)
var shake = 8

var lerpStep : float = 0.02

func _ready():
	randomize()
	
func _process(delta):
	
	position -= counter_offset
	trauma = min(max(trauma - delta*1.5, 0), 1)
	counter_offset = Vector2((2*randf() - 1)*shake*trauma*trauma, (2*randf() - 1)*shake*trauma*trauma)
	position += counter_offset
	
	score = lerpf(score, target_score, lerpStep)
	text = str(roundi(score))
	
	if int(score) == target_score:
		set_process(false)

func initScore(scoreVal):
	text = str(scoreVal)
	score = scoreVal
	target_score = scoreVal

func score_event(scoreValue, directSet : bool = false, doShake : bool = true):
	set_process(true)
	
	if directSet:
		target_score = scoreValue
	else:
		target_score += scoreValue
	
	if doShake:
		trauma += 0.9
