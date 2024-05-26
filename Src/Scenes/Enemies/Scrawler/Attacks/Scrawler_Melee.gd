extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_scrawler_melee_area_body_entered(body):
	Signal_bus.emit_signal("Player_Damaged",1)

func _on_timer_timeout():
	self.queue_free()
