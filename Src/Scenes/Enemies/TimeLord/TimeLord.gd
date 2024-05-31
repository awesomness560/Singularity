extends CharacterBody2D

@export var magicStrength : int = 1
var nearby = []
func _physics_process(delta):
	slowNearby()
	

func slowNearby():
	for i in nearby:
		if "velocity" in i:
			i.velocity = i.velocity / Vector2(1.5+magicStrength,1.5+magicStrength)

func _on_area_2d_body_entered(body):
	if body not in nearby:
		nearby.append(body)
		
		

func _on_area_2d_body_exited(body):
	if body in nearby:
		nearby.erase(body)
