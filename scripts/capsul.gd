@tool
extends MeshInstance3D

@onready var mi_cutplane:MeshInstance3D = get_node("%cutPlane")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (mi_cutplane):
		material_override.set_shader_parameter("cutplane",mi_cutplane.global_transform);
	else:
		mi_cutplane= get_node("%cutPlane")
	pass
