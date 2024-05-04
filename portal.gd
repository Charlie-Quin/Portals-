extends Node3D

@export var targetPortal : Node3D


@onready var camera : Camera3D = $SubViewport/Camera3D

var player : CharacterBody3D

@onready var viewport = $SubViewport
@onready var materialOverride = $sprite/Sprite3D.material_override

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#var linked: Node = links[portal]
	#var link_viewport: Viewport = linked.get_node("Viewport")
	#var tex := link_viewport.get_texture()
	#var mat = portal.get_node("Screen").get_node("Back").material_override
	#mat.set_shader_param("texture_albedo", tex)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not player:
		player = Globals.player
		if not player:
			return
	
	
	# we want the player's global matrix as relative to the target portal
	var m = targetPortal.global_transform * global_transform.affine_inverse() * player.neck.global_transform
	camera.transform = m
	
	if materialOverride and viewport:
		materialOverride.set_shader_parameter("texture_albedo", viewport.get_texture())
	
	pass









