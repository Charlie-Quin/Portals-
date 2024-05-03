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
	
	var offsetToOtherPortal = - (stuff.position - targetPortal.stuff.position )
	
	var cameraOffset = -(stuff.global_position - player.global_position)
	
	camera.position =  cameraOffset + offsetToOtherPortal
	
	print(camera.position)
	
	pass









