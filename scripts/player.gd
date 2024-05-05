extends CharacterBody3D

@onready var head : Node3D = $head/neck
@onready var neck = $head
@onready var camera = $head/neck/Camera3D

const SPEED = 5.0
const ACCEL = 6.0
const JUMP_VELOCITY = 4.5

var currentPortal : portal = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Globals.player = self
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input = Input.get_vector("a","d","w","s").normalized()
	
	var newBasis = basis if camera.current else Basis(Vector3.RIGHT,0) 
	
	
	var targetVel = (input.y * newBasis.z + input.x * newBasis.x).normalized() * SPEED
	
	velocity.x = lerp(velocity.x,targetVel.x,ACCEL * delta)
	velocity.z = lerp(velocity.z,targetVel.z,ACCEL * delta)
	
	handlePortals(delta)
	
	move_and_slide()
	
	rotateToUp(delta)
	
	handlePortals(delta)
	

func rotateToUp(delta):
	
	var difference = basis.y .angle_to(Vector3.UP)
	#print(difference)
	
	if difference < deg_to_rad(2):
		return
	
	var axis = (Vector3.UP.cross(global_transform.basis.y.normalized())).normalized()
	
	var p = -0.04
	rotate(axis,difference * p)
	


@onready var dummyMesh : MeshInstance3D = $dummyMesh
@onready var realMesh : MeshInstance3D = $realMesh
func handlePortals(delta):
	
	dummyMesh.visible = true if currentPortal else false
	
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

const SENSITIVITY = 0.0015

func _input(event):
	
	
	pass
	if event is InputEventMouseMotion:
		rotation.y += (-event.relative.x * SENSITIVITY)
		
		
		if false and !camera.current:
			return
		
		neck.rotation.x += (-event.relative.y * SENSITIVITY)
		neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(-90),deg_to_rad(90))
		

