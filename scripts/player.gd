extends PortalKinematicBody

@onready var head : Node3D = $head/neck
@onready var neck = $head
@onready var camera = $head/neck/Camera3D

@export var pearlPath = ""

const SPEED = 5.0
const ACCEL = 6.0
const JUMP_VELOCITY = 4.5

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
	
	if Input.is_action_just_pressed("teleport"):
		throwPearl()
	
	


const SENSITIVITY = 0.0015

func _input(event):
	
	
	pass
	if event is InputEventMouseMotion:
		rotation.y += (-event.relative.x * SENSITIVITY)
		
		
		if false and !camera.current:
			return
		
		neck.rotation.x += (-event.relative.y * SENSITIVITY)
		neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(-90),deg_to_rad(90))
		

func teleport(globalTransform,normal):
	
	global_transform.origin = globalTransform.origin
	
	global_position += normal * 1.2
	


func throwPearl():
	var pearl = load(pearlPath).instantiate()
	pearl.teleportTarget = self
	
	get_parent().add_child(pearl)
	
	pearl.velocity = -neck.global_basis.z * 10
	pearl.global_position = neck.global_position + -neck.global_basis.z * 1.1
	
	
	
