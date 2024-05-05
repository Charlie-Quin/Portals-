extends Node3D


func _physics_process(delta):
	
	if Input.is_action_pressed("grab"):
		
		grab(delta)
		
	
	

func grab(delta):
	
	for body in $itemDetect.get_overlapping_bodies():
		
		if not body is RigidBody3D:
			continue
		
		#print("found one!")
		
		body = body as RigidBody3D
		
		var desiredVelocity = (global_position - body.global_position) * 10
		
		#print(desiredVelocity)
		
		body.linear_velocity = body.linear_velocity.move_toward(desiredVelocity,100 * delta)
		
		pass
	
	
