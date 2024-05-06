extends Node

var player : CharacterBody3D

var VRCAMERA : XRCamera3D

var interface = XRInterface
var initializedVR = false
func _ready():
	
	if initializedVR:
		return
	initializedVR = true
	
	interface = XRServer.find_interface("OpenXR")
	
	if interface and interface.is_initialized():
		print("yipee")
		get_viewport().use_xr = true
	
	pass
