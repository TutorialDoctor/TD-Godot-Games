extends Spatial
# Simply add this script to a spatial node, and you have a fly around camera.


# VARIABLES
var yaw = 0 # The direction of the head (which is the node this script is applied to)
var pitch = 0 # The tilt of the camera (a child of this node)
var view_sensitivity = .3
var projection
var camera
var quad
export var move_speed = 2


# SETUP
func _ready():
	set_process(true)
	set_process_input(true)
	
	# The camera could have been added manually, but I wanted this to be plug n' play. 
	camera = Camera.new()
	camera.make_current()
	add_child(camera)


# EVENT DRIVEN
# This code makes the camera aim. It alone does the aiming.
# Borrowed Code (tried to understand how it does what it does, but it works)
func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		yaw = fmod(yaw - event.relative_x * view_sensitivity, 360)
		pitch = max(min(pitch - event.relative_y * view_sensitivity, 90), -90)
		set_rotation(Vector3(0, deg2rad(yaw), 0))
		camera.set_rotation(Vector3(deg2rad(pitch), 0, 0))


# GAME LOOP
# The game loop processes the code therin every game frame (about 60fps)
func _process(delta):
	# Return a normal vector in worldspace, that is the result of projecting a point on the Viewport rectangle by the camera projection. 
	# Basically it converts the mouse position to a 3d location/vector
	projection = camera.project_ray_normal(get_viewport().get_mouse_pos())
	# Now I can move in the direction of the mouse
	

	if Input.is_action_pressed("ui_up"):
		set_translation(Vector3(get_translation()+projection*delta*move_speed)) 
		# multiplied by delta for smoother translation motion

	if Input.is_action_pressed("ui_down"):
		set_translation(Vector3(get_translation()-projection*delta*move_speed))
	
	if Input.is_key_pressed(81) or Input.is_key_pressed(16777217): # Q and Escape
		get_tree().quit()
	
	if Input.is_key_pressed(82): # R
		get_tree().reload_current_scene()


# OTHER BUILT-IN FUNCTIONS
func _enter_tree():
	# Hide mouse upon entering the tree/level
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);

func _exit_tree():
	# Show mouse upon exiting the tree/level
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
