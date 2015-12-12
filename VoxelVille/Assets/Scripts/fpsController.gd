extends Spatial
# Simply add this script to a spatial node, and you have a first person camera
# This is a heavily sifted and adapted version of the "FPS test" demo, which should be much easier to use, edit, and understand


# VARIABLES
var yaw = 0 # The direction of the head (which is the node this script is applied to)
var pitch = 0 # The tilt of the camera (a child of this node)
var view_sensitivity = .3
var camera
export var move_speed = 2.0
var tex = preload('res://icon.png')
var direction = Vector3()
var aim
var eyes
var view_distance = 1000
var status
export var eyesight = 10 #how far you can see


# SETUP
func _ready():
	set_process(true)
	set_process_input(true)

	# The camera could have been added manually, but I wanted this to be plug n' play.
	camera = Camera.new()
	camera.make_current()
	add_child(camera)
	camera.set('far',view_distance)
	move_camera_up(10)
	
	var yaw2 = Spatial.new()
	yaw2.set_name('yaw')
	add_child(yaw2)
	
	eyes = get_node('Eyes')
	eyes.set('cast_to',Vector3(0,0,-eyesight))
	status = get_node("Satus")


# GAME LOOP
# The game loop processes the code therin every game frame (about 60fps)
func _process(delta):
	walk()
	see()
	# To quit and reload the level
	if Input.is_key_pressed(81) or Input.is_key_pressed(16777217):
		get_tree().quit()
	if Input.is_key_pressed(82):
		get_tree().reload_current_scene()


# INPUT EVENTS
# This code makes the camera aim. It alone does the aiming.
# Borrowed Code (tried to understand how it does what it does, but it works)
func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		yaw = fmod(yaw - event.relative_x * view_sensitivity, 360)
		pitch = max(min(pitch - event.relative_y * view_sensitivity, 90), -90)
		set_rotation(Vector3(0, deg2rad(yaw), 0))
		camera.set_rotation(Vector3(deg2rad(pitch), 0, 0))


func walk():
	aim = get_node("yaw").get_global_transform().basis
	if Input.is_action_pressed("forwards"):
		direction -= aim[2]
	if Input.is_action_pressed("backwards"):
		direction += aim[2]
	if Input.is_action_pressed('right'):
		direction +=aim[0]
	if Input.is_action_pressed('left'):
		direction -=aim[0]
	set_translation(direction*move_speed)


# EXTRA FUNCTIONS
func see():
	if eyes.is_colliding():
		print(eyes.get_collider().get_name())
		

func hide_on_click():
	if Input.is_mouse_button_pressed(1):
		if eyes.is_colliding():
			print(eyes.get_collider().get_name())
			eyes.get_collider().get_parent().hide()

func move_camera_up(x):
	camera.set_translation(camera.get_translation()+Vector3(0,x,0))


# OTHER BUILT-IN FUNCTIONS
func _enter_tree():
	# Hide mouse upon entering the tree/level
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);

func _exit_tree():
	# Show mouse upon exiting the tree/level
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
