extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var nearby = []

var attacking = false

func _physics_process(delta):
	# Add the gravity.
	if len(nearby) > 1:
		self.global_rotation += (self.get_angle_to(nearby[0].global_position)-global_rotation)/2
			
		if angle_difference(get_angle_to(nearby[0].global_position),self.global_rotation) > -.1 and angle_difference(get_angle_to(nearby[0].global_position),self.global_rotation) < .1:
			if global_position.distance_to(nearby[0].global_position) < 60:
				attacking = true
				$ScrawlerMeleeArea/MeleeParticles.emitting = true

	velocity = Vector2(10,0).rotated(global_rotation)
	move_and_collide(velocity)

#Nearby enters
func _on_area_2d_body_entered(body):
	if body not in nearby:
		nearby.append(body)

#Nearby exits
func _on_area_2d_body_exited(body):
	if body in nearby:
		nearby.erase(body)


func _on_scrawler_melee_area_body_entered(body):
	if attacking:
		pass
		#body.Health -= 1
