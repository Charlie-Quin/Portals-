@tool
extends MeshInstance3D

var cutPlane

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (cutPlane):
		material_override.set_shader_parameter("cutplane",cutPlane.global_transform);
		
		for child in get_children():
			if child.has_method("setCutPlane"):
				child.setCutPlane(cutPlane)
		

func setCutPlane(newCutPlane):
	cutPlane = newCutPlane
