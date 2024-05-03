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
	
	print(camera.position)
	
	pass









