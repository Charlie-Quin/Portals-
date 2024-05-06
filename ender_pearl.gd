extends PortalKinematicBody

var teleportTarget #teleport targetMust have the "teleport" method that takes a globaltransform and a normal

var gravity = 10

func _physics_process(delta):
	
	velocity.y -= gravity * delta
	
	print(velocity)
	
	move_and_slide()
	
	if get_last_slide_collision() and teleportTarget:
		pass
		teleportTarget.teleport(global_transform,get_last_slide_collision().get_normal())
		queue_free()
	
	handlePortals(delta)
	
	pass

