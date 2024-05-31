extends Node2D
class_name Biome

@export var startingMarker : Node2D ##A node indicating where the floor of the biome starts
@export var endingMarker : Node2D ##A node indicating where the floor of the biome ends

func config(marker : Node2D): ##Pass in the ending marker of the previous biome to configure
	#In here we set the position equal to the ending marker position
	#We then add in the offset of the starting marker to make everything connect
	global_position = marker.global_position
	global_position += global_position - startingMarker.global_position


func _on_portal_area_body_entered(body):
	if body is Player:
		Signal_bus.reachedPortal.emit()
