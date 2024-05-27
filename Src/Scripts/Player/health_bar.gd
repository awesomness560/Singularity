extends ProgressBar
class_name HealthBar

@export var timer : Timer
@export var damage_bar : ProgressBar

var health = 0

func _ready():
	#print(damage_bar)
	pass

func _set_health(new_health):
	var prevHealth = health
	health = min(max_value, new_health)
	value = new_health
	
	if health < prevHealth:
		timer.start()
	else:
		damage_bar.value = health

func init_health(_health):
	health = _health
	max_value = _health
	value = _health
	damage_bar.max_value = _health
	damage_bar.value = _health

func _on_timer_timeout():
	damage_bar.value = health
