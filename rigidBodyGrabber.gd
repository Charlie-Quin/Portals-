extends Node3D

var currentPortal

var pullPower = 1000
var maxRange = 1
var desiredVelocityMultiplier = 60

func _physics_process(delta):
	
	if currentPortal:
		print("yes has current portal")
		$itemDetectClone.global_transform.origin = currentPortal.getSwappedPosition(global_transform).origin
		$itemDetectClone.global_transform.basis = currentPortal.getSwappedPosition(global_transform).basis
	
	if Input.is_action_pressed("grab"):
		
		grab(delta)
		
	
	

func grab(delta):
	
	for body in $itemDetect.get_overlapping_bodies():
		moveBodyToward(body,$itemDetect.global_transform,delta)
		
	
	if currentPortal:
		for body in $itemDetectClone.get_overlapping_bodies():
			moveBodyToward(body,$itemDetectClone.global_transform,delta)
			
	
	

func moveBodyToward(body,globalTransform,delta):
	if not body is RigidBody3D:
		return
	
	#print("found one!")
	
	body = body as RigidBody3D
	
	var difference = (globalTransform.origin - body.global_position)
	
	var desiredVelocity = difference * desiredVelocityMultiplier
	
	print(desiredVelocity.normalized())
	
	var forceStrength = getStrengthMultiplier(difference.length(),maxRange) * pullPower * delta
	
	print(desiredVelocity.normalized() * forceStrength)
	
	body.apply_force(desiredVelocity.normalized() * forceStrength)
	

#will return 1 if distance is 0, and with return 0 if distance is more than or equal to max distance
func getStrengthMultiplier(distance, maxDistance):
	
	return clamp( distance/(-maxDistance/2) + 1,0.0,1.0);
	
	pass
