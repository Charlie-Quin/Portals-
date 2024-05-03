extends Node3D

@export var targetPortal : Node3D

@onready var stuff : Node3D = $SubViewport/stuff
@onready var camera : Camera3D = $SubViewport/stuff/Camera3D

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
		var cameraOffset = -(stuff.global_position - player.global_position)
		camera.global_position =  cameraOffset + targetPortal.stuff.global_position
	
	
	var globalOffset = -(stuff.global_transform.origin - player.global_transform.origin)
	var myBasis = global_transform.basis
	var localOffset = Vector3(globalOffset.dot(myBasis.x),globalOffset.dot(myBasis.y),globalOffset.dot(myBasis.z))
	
	var targetBasis = global_transform.basis
	var newPosition = (
		targetPortal.stuff.global_transform.origin +
		targetBasis.z * localOffset.z +
		targetBasis.x * localOffset.x + 
		targetBasis.y * localOffset.y 
		)
	
	print(camera.position)
	
	pass









