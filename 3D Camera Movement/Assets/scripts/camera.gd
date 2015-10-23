# By the Tutorial Doctor
# Tue Oct 13 20:23:16 EDT 2015
extends Camera
var sensitivity = 40

func _ready():
	set_process(true)
	print(get_translation())

func _process(delta):
	var projection = project_ray_normal(get_viewport().get_mouse_pos())
	look_at_from_pos(get_translation(),projection*sensitivity,Vector3(0,1,0))

	# UNUSED CODE
	#print(projection)
	#var mouse_2d = get_viewport().get_mouse_pos()
	#print(mouse_2d)
	#var mouse_3d = unproject_position(projection)
	#print(mouse_3d)

	
