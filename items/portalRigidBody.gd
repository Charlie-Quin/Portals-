extends RigidBody3D


func _physics_process(delta):
	
	handlePortals(delta)
	



@export var dummyMesh : MeshInstance3D 
@export var realMesh : MeshInstance3D

var currentPortal

func handlePortals(delta):
	
	dummyMesh.visible = true if currentPortal else false
	
	#if we're not in a portal skip this step
	if !currentPortal:
		return
	
	dummyMesh.global_transform = currentPortal.getSwappedPosition(global_transform)
	dummyMesh.cutPlane = currentPortal.targetPortal.cutPlane
	
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
