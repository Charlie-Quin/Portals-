extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



var z_near = 0
var z_far = 0

var frusSize = 0

var frusOffset = Vector2.ZERO

func _on_h_slider_value_changed(value):
	near = value
	
	#set_frustum(frusSize, frusOffset, z_near, z_far)
	pass # Replace with function body.


func _on_far_value_changed(value):
	z_far = value
	
	set_frustum(frusSize, frusOffset, z_near, z_far)
	pass # Replace with function body.


func _on_size_value_changed(value):
	frusSize = value
	
	set_frustum(frusSize, frusOffset, z_near, z_far)
	pass # Replace with function body.


func _on_offsetX_value_changed(value):
	frusOffset.x = value
	
	set_frustum(frusSize, frusOffset, z_near, z_far)
	pass # Replace with function body.


func _on_offsetY_value_changed(value):
	frusOffset.y = value
	
	set_frustum(frusSize, frusOffset, z_near, z_far)
	pass # Replace with function body.
