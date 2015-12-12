# By the Tutorial Doctor
# Tue Oct 13 20:23:16 EDT 2015
extends Camera
var projection
export var sensitivity = 50

func _ready():
	set_process(true)
	print(get_translation())

func _process(delta):
	projection = project_ray_normal(get_viewport().get_mouse_pos())
	look_at_from_pos(get_translation(),projection*sensitivity,Vector3(0,1,0))
	
	# Now I can move in that direction.
	if Input.is_action_pressed("ui_up"):
		set_translation(Vector3(get_translation()+projection))

	if Input.is_action_pressed("ui_down"):
		set_translation(Vector3(get_translation()-projection))

	# I just have to limit the cursot position
	
	# UNUSED CODE
	#print(projection)
	#var mouse_2d = get_viewport().get_mouse_pos()
	#print(mouse_2d)
	#var mouse_3d = unproject_position(projection)
	#print(mouse_3d)