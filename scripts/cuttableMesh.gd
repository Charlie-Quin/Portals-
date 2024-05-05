@tool
extends Node3D

var cutPlane
var cut = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (cutPlane):
		
		if "material_override" in self and self.material_override:
			self.material_override.set_shader_parameter("cutplane",cutPlane.global_transform);
			self.material_override.set_shader_parameter("cut",cut);
		
		for child in get_children():
			if child.has_method("setCutPlane"):
				child.setCutPlane(cutPlane,cut)
		

func setCutPlane(newCutPlane,newCut):
	cutPlane = newCutPlane
	cut = newCut
