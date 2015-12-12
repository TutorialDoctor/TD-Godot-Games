extends Spatial

# Apply this script to a spatial node, and you have a fly around camera

var yaw = 0
var pitch = 0
var view_sensitivity = .3
var projection
var camera


func _ready():
	set_process(true)
	set_process_input(true)

	camera = Camera.new()
	camera.make_current()
	add_child(camera)



func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		yaw = fmod(yaw - event.relative_x * view_sensitivity, 360)
		pitch = max(min(pitch - event.relative_y * view_sensitivity, 90), -90)
		set_rotation(Vector3(0, deg2rad(yaw), 0))
		camera.set_rotation(Vector3(deg2rad(pitch), 0, 0))

func _process(delta):
	projection = camera.project_ray_normal(get_viewport().get_mouse_pos())
	
	# Now I can move in that direction.
	if Input.is_action_pressed("ui_up"):
		set_translation(Vector3(get_translation()+projection))

	if Input.is_action_pressed("ui_down"):
		set_translation(Vector3(get_translation()-projection))

