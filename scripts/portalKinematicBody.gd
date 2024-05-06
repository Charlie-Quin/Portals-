extends CharacterBody3D

class_name PortalKinematicBody

var currentPortal : portal

func rotateToUp(delta):
	
	var difference = basis.y .angle_to(Vector3.UP)
	#print(difference)
	
	if difference < deg_to_rad(2):
		return
	
	var axis = (Vector3.UP.cross(global_transform.basis.y.normalized())).normalized()
	
	var p = -0.04
	rotate(axis,difference * p)
	


@export var dummyMesh : Node3D
@export var realMesh : Node3D
func handlePortals(delta):
	
	dummyMesh.visible = true if currentPortal else false
	dummyMesh.cut = true if currentPortal else false
	realMesh.cut = true if currentPortal else false
	
	#if we're not in a portal skip this step
	if !currentPortal:
		return
	
	dummyMesh.global_transform = currentPortal.getSwappedPosition(global_transform)
	dummyMesh.cutPlane = currentPortal.targetPortal.cutPlane
	
	realMesh.cutPlane = currentPortal.cutPlane
	
	
	
	var wentThroughPortal = currentPortal.global_transform.basis.z.angle_to((currentPortal.global_transform.origin - global_transform.origin + velocity * delta)) > PI/2
	
	if wentThroughPortal:
		swapToNewPosition()
		
		handlePortals(delta)
	

func swapToNewPosition():
	
	var OGTransform = global_transform
	
	global_transform = currentPortal.getSwappedPosition(global_transform)
	
	velocity = currentPortal.adjustToNewTransform(velocity,OGTransform,global_transform)
	
	currentPortal = currentPortal.targetPortal
	
	pass
