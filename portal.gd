extends Node3D

@export var targetPortal : Node3D


@onready var camera : Camera3D = $SubViewport/Camera3D

var player : CharacterBody3D

#@onready var viewport = $SubViewport
#@onready var materialOverride = $sprite/Sprite3D.material_override

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
	var m = targetPortal.global_transform.rotated_local(Vector3.UP,PI) * global_transform.affine_inverse() * player.neck.global_transform
	camera.transform = m
	
	camera.near = max(0.05,(camera.position - targetPortal.global_position).length() - 1.5)
	
	var player_LocalToSelf = global_transform.affine_inverse() * player.global_transform
	var global_playerLocalToOtherPortal = targetPortal.global_transform.rotated_local(Vector3.UP,PI) * player_LocalToSelf
	
	if Input.is_action_just_pressed("ui_accept") and name == "portal1":
		player.global_transform = global_playerLocalToOtherPortal;
	
	#if materialOverride and viewport:
		#materialOverride.set_shader_parameter("texture_albedo", viewport.get_texture())
	
	pass









