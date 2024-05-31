extends Label
class_name ScoreLabel

var target_score = 0
var score = 0

var trauma = 0
var counter_offset = Vector2(0, 0)
var shake = 8

func _ready():
	randomize()
	
func _process(delta):
	
	position -= counter_offset
	trauma = min(max(trauma - delta*1.5, 0), 1)
	counter_offset = Vector2((2*randf() - 1)*shake*trauma*trauma, (2*randf() - 1)*shake*trauma*trauma)
	position += counter_offset
	
	score = lerpf(score, target_score, 0.02) 
	text = str(int(score))
	
	if int(score) == target_score:
		set_process(false)
	
func score_event(scoreValue):
	await get_tree().create_timer(0.5).timeout
	
	set_process(true)
	
	var score_value = 100001# + randi()%6
	target_score += scoreValue
	
	trauma += 0.9
