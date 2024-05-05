extends RigidBody3D


@export var realMesh : Node3D
@export var dummyMesh : Node3D 

func _physics_process(delta):
	
	handlePortals(delta)
	




var currentPortal

func handlePortals(delta):
	
	dummyMesh.visible = true if currentPortal else false
	#print(dummyMesh.global_position)
	
	#if we're not in a portal skip this step
	if !currentPortal:
		return
	
	dummyMesh.global_transform = currentPortal.getSwappedPosition(global_transform)
	dummyMesh.cutPlane = currentPortal.targetPortal.cutPlane
	
	#print(currentPortal.getSwappedPosition(global_transform).basis)
	
	realMesh.cutPlane = currentPortal.cutPlane
	
	
	
	var wentThroughPortal = currentPortal.global_transform.basis.z.angle_to((currentPortal.global_transform.origin - global_transform.origin + linear_velocity * delta)) > PI/2
	
	if wentThroughPortal:
		swapToNewPosition()
		
		handlePortals(delta)
	

func swapToNewPosition():
	
	var OGTransform = global_transform
	
	global_transform = currentPortal.getSwappedPosition(global_transform)
	
	linear_velocity = currentPortal.adjustToNewTransform(linear_velocity,OGTransform,global_transform)
	
	currentPortal = currentPortal.targetPortal
	
	pass
