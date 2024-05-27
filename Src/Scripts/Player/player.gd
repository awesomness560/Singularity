extends CharacterBody2D
var radiating = false
var radiatingTimeLeft = 0
var inradiation = []
func _physics_process(delta):
	if Input.is_action_just_released("radiation_Blast") and not radiating:
		radiating = true
		radiatingTimeLeft = 40
		$RadiationBlastArea/CollisionShape2D.disabled = false
		$RadiationBlastArea/RadiationParticles.emitting = true

func _on_radiation_blast_area_body_entered(body):
	if body not in inradiation:
		inradiation.append(body)

func _on_radiation_move_timer_timeout():
	#TODO: Add damage to i
	for i in inradiation:
		pass
	if radiating and radiatingTimeLeft > 0:
			radiatingTimeLeft -= 1
			print(int(radiatingTimeLeft/.1))
			$RadiationBlastArea/CollisionShape2D.shape.radius = int(radiatingTimeLeft/.1)
			$RadiationBlastArea/RadiationParticles.emission_sphere_radius = int(radiatingTimeLeft/.1) 
			if radiatingTimeLeft <= 0:
				radiating = false
	else:
		$RadiationBlastArea/RadiationParticles.emitting = false
		$RadiationBlastArea/CollisionShape2D.disabled = true


func _on_radiation_blast_area_body_exited(body):
	if body in inradiation:
		inradiation.erase(body)
		
func grow(scaleFactor):
	self.apply_scale(Vector2(scaleFactor,scaleFactor))



func _on_particle_collector_area_entered(area):
	print(area.name)
	if area.particleType == "Quark":
		grow(area.size)
		area.queue_free()
