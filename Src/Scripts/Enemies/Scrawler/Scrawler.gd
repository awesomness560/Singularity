extends CharacterBody2D


const SPEED = 300.0
@export var damager : Node 
var nearby = []
#Used for freeing the scrawler from a stuck position
var lastPosition = self.global_position
var lastRotation = self.global_rotation
var stuck = false
var attacking = false
func _physics_process(delta):
	# Add the gravity.
	if len(nearby) > 0 and !stuck:
		self.global_rotation += (self.get_angle_to(nearby[0].global_position))*.1
		velocity = Vector2(8,0).rotated(global_rotation)
	move_and_collide(velocity)
	
#180 rotation if stuck in same position
func _check_stuck(last_position):
	if self.global_position.distance_to(last_position) < 20:
		stuck = true
		self.global_rotation = lastRotation+PI
		velocity = Vector2(5,0).rotated(global_rotation)

#Nearby enters
func _on_area_2d_body_entered(body):
	if body not in nearby:
		nearby.append(body)
		
#Nearby exits
func _on_area_2d_body_exited(body):
	if body in nearby:
		nearby.erase(body)


func _on_scrawler_melee_area_body_entered(body):
	attacking = true
	$ScrawlerMeleeArea/MeleeParticles.emitting = true
	$ScrawlerMeleeArea/ColorRect.color = Color8(255,0,0,255)
	damager.dealDamage(body)


func _on_scrawler_melee_area_body_exited(body):
	if attacking:
		attacking = false
		$ScrawlerMeleeArea/ColorRect.color = Color8(255,255,255,255)
		pass


func _on_last_pos_rot_timer_timeout():
	if self.global_position.distance_to(lastPosition) < 10:
		_check_stuck(lastPosition)
	else:
		stuck = false
	lastPosition = self.global_position
	lastRotation = self.global_rotation
	
