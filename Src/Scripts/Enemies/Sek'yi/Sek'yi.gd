extends CharacterBody2D


const SPEED = 300.0

var nearby = []
#Used for freeing the scrawler from a stuck position
var lastPosition = self.global_position
var lastRotation = self.global_rotation
var stuck = false
var attacking = false
var direction = -5
@onready var Scrawler = preload("res://Src/Scenes/Enemies/Scrawler/Scrawler.tscn")
func _physics_process(delta):
	# Add the gravity.
	if len(nearby) == 0:
		$"Sek'yi".global_rotation += PI/16

func _on_nearby_area_body_exited(body):
	if body in nearby:
		nearby.erase(body)

func _on_nearby_area_body_entered(body):
	if body not in nearby:
		nearby.append(body)



func _on_spawn_timer_timeout():
	if len(nearby) > 0:
		var scrawlerInstance = Scrawler.instantiate()
		scrawlerInstance.global_position = self.global_position
		scrawlerInstance.top_level = true
		add_sibling(scrawlerInstance)
		Signal_bus.enemySpawned.emit()
