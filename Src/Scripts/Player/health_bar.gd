extends ProgressBar
class_name HealthBar

@export var timeToTween : float = 0.2 ##The time it takes for the progress bar to reach the real value
@export var timer : Timer
@export var damage_bar : ProgressBar

var damageBarTween : Tween
var healthBarTween : Tween

var health = 0

func _set_health(new_health):
	var prevHealth = health
	health = min(max_value, new_health)
	tweenHealth(health)
	
	if health < prevHealth:
		timer.start()
	else:
		tweenDamage(health)

func init_health(_health):
	health = _health
	max_value = _health
	value = _health
	damage_bar.max_value = _health
	damage_bar.value = _health

func _on_timer_timeout():
	tweenDamage(health)
	
func tweenHealth(_health):
	if healthBarTween:
		healthBarTween.kill()
		
	healthBarTween = create_tween()
	healthBarTween.tween_property(self, "value", _health, timeToTween)

func tweenDamage(_health):
	if damageBarTween:
		damageBarTween.kill()
	
	damageBarTween = create_tween()
	damageBarTween.tween_property(damage_bar, "value", _health, timeToTween)
