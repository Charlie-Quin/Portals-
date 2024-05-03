extends CharacterBody3D

@onready var head : Node3D = $head/neck
@onready var neck = $head

const SPEED = 5.0
const ACCEL = 6.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input = Input.get_vector("a","d","w","s").normalized()
	
	var targetVel = (input.y * basis.z + input.x * basis.x).normalized() * SPEED
	
	velocity.x = lerp(velocity.x,targetVel.x,ACCEL * delta)
	velocity.z = lerp(velocity.z,targetVel.z,ACCEL * delta)
	
	move_and_slide()



const SENSITIVITY = 0.0015

func _input(event):
	pass
	if event is InputEventMouseMotion:
		rotation.y += (-event.relative.x * SENSITIVITY)
		
		neck.rotation.x += (-event.relative.y * SENSITIVITY)
		neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(-90),deg_to_rad(90))
		

