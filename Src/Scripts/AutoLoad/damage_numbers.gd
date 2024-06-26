extends Node

@export var criticalFontColor : Color
@export var labelSettings : LabelSettings
var fontColor : Color

func _ready():
	fontColor = labelSettings.font_color

func displayNumber(value : int, position : Vector2, isCritical : bool = false):
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = labelSettings
	
	var color = fontColor
	if isCritical:
		color = criticalFontColor
	else:
		color = fontColor
	if value == 0:
		color = "#FFF8"
	
	number.label_settings.font_color = color
	#number.label_settings.font_size = 18
	#number.label_settings.outline_color = "#000"
	#number.label_settings.outline_size = 1
	get_tree().current_scene.add_child(number)
	#call_deferred("add_child", number)
	
	#await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	if is_instance_valid(number):
		number.queue_free()
