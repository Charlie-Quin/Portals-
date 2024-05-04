extends Node3D

@export var targetPortal : Node3D


@onready var camera : Camera3D = $SubViewport/Camera3D

var player : CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not player:
		player = Globals.player
		if not player:
			return
	
	#this bit works if there are no rotations
	if false:
		var cameraOffset = -(global_position - player.global_position)
		camera.global_position =  cameraOffset + targetPortal.global_position
	
	#works with rotations on the portals! not the player. Let's use the real functions to do this now.
	if false:
		var globalOffset = -(global_transform.origin - player.global_transform.origin)
		var myBasis = global_transform.basis
		var localOffset = Vector3(globalOffset.dot(myBasis.x),globalOffset.dot(myBasis.y),globalOffset.dot(myBasis.z))
		
		var targetBasis = targetPortal.global_transform.basis
		var newPosition = (
			targetPortal.global_transform.origin +
			targetBasis.z * localOffset.z +
			targetBasis.x * localOffset.x + 
			targetBasis.y * localOffset.y 
			)
		
		camera.position = newPosition
	
	#this works great for position!
	var localOffset = to_local(player.global_transform.origin)
	var newPosition = targetPortal.to_global(localOffset)
	camera.position = newPosition
	
	#doesn't work
	if false:
		# Calculate the combined matrix
		var matrix = global_transform * targetPortal.transform * player.neck.global_transform
		# Apply rotation to the camera
		camera.quaternion = matrix.basis.get_rotation_quaternion()
	
	
	# we want the player's global matrix as relative to the target portal
	
	var player_local_to_A = global_transform.affine_inverse() * player.neck.global_transform
	
	var newMatrix = targetPortal.global_transform * player_local_to_A
	
	camera.transform.basis = newMatrix.basis
	camera.transform.origin = newMatrix.origin
	
	#this code is run by "portal in"
	#??? = -player.global_transform.basis.z + self.transform.basis.z + targetPortal.basis.z
	
	#camera.look_at(camera.global_position - player.neck.global_transform.basis.z + self.transform.basis.z - targetPortal.transform.basis.z)
	
	pass









