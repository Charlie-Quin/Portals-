extends Node3D

class_name portal

@export var targetPortal : Node3D


@onready var camera : Camera3D = $SubViewport/Camera3D

var player : CharacterBody3D

@export var color = Color.RED

@onready var cutPlane = $sprite/portalMesh

#@onready var viewport = $SubViewport
#@onready var materialOverride = $sprite/Sprite3D.material_override

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$sprite/portalMesh.material_override.set_shader_parameter("portal_colour",color)
	
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
	
	if Input.is_action_just_pressed("ui_accept") and name == "portal1": #is_behind(player.global_transform) and global_position.distance_to(player.global_position) < 1.5:# and name == "portal1":
		
		
		var playerBasis = player.global_transform.basis
		#var oldPlayerVel = (player.velocity.z * playerBasis.z + player.velocity.x * playerBasis.x + player.velocity.y * playerBasis.y)
		
		var oldPlayerVel = Vector3(player.velocity.dot(playerBasis.x),player.velocity.dot(playerBasis.y),player.velocity.dot(playerBasis.z))
		
		#var oldPlayerVel = player.to_local(player.velocity)
		
		print("old",oldPlayerVel)
		
		player.global_transform = global_playerLocalToOtherPortal;
		
		var newBasis = player.global_transform.basis
		
		var newVel = (oldPlayerVel.z * newBasis.z + oldPlayerVel.x * newBasis.x + oldPlayerVel.y * newBasis.y)
		
		print(oldPlayerVel.length(),newVel.length())
		
		player.velocity = newVel
		
		print("new",player.velocity)
		
	
	
	#if materialOverride and viewport:
		#materialOverride.set_shader_parameter("texture_albedo", viewport.get_texture())
	
	pass

func adjustToNewTransform(vector : Vector3,oldGlobalTransform,newGlobalTransform):
	var OGBasis = oldGlobalTransform.basis
	var oldVectorLocal = Vector3(vector.dot(OGBasis.x),vector.dot(OGBasis.y),vector.dot(OGBasis.z))
	
	var newBasis = newGlobalTransform.basis
	var newVec = (oldVectorLocal.z * newBasis.z + oldVectorLocal.x * newBasis.x + oldVectorLocal.y * newBasis.y)
	
	return newVec




func getSwappedPosition(globalTransform : Transform3D) -> Transform3D:
	
	var object_LocalToSelf = global_transform.affine_inverse() * globalTransform
	return targetPortal.global_transform.rotated_local(Vector3.UP,PI) * object_LocalToSelf
	
	

func is_behind(pos: Transform3D,byHowMuch : float = 0.0):
	#print(name," ",pos.origin.dot(basis.z))
	return to_local(pos.origin).dot(basis.z) > byHowMuch;
	
	








func _on_object_detector_body_entered(body):
	
	if body.is_in_group("portalAble"):
		body.currentPortal = self
	
	pass # Replace with function body.


func _on_object_detector_body_exited(body):
	
	if body.is_in_group("portalAble") and body.currentPortal == self:
		body.currentPortal = null
	
	pass # Replace with function body.
