#-----------------------------
# Godot Code Snippets (2D)    |
# By the Tutorial Doctor      |
# Fri Sep 18 13:14:07 EDT 2015|
#-----------------------------


# MAKE AN OBJECT FOLLOW THE MOUSE
func followMouse(x):
	var mouse_position = get_viewport().get_mouse_pos()
	x.set_pos(mouse_position)

#Example Usage: followMouse(cursor)



# MAKE AN OBJECT LOOK AT THE MOUSE
func lookAtMouse(x):
	var mouse_position = get_viewport().get_mouse_pos()
	x.look_at(mouse_position)

#Example Usage: lookAtMouse(arrow)



# MAKE AN OBJECT FLIPABLE
func makeFlipable(x,boolean=true):
	# If the parameter is false, exit the function
	if boolean == false:
		return
	# Otherwise if the parameter is true...
	elif boolean == true:
		# And if left arrow is pressed..
		if Input.is_action_pressed("ui_left"):
			# Set the Flip H property to true.
			x.set('flip_h',true)
		# Otherwise, if the right arrow is pressed...
		elif Input.is_action_pressed("ui_right"):
			# Set the Flip H property to false
			x.set('flip_h',false)

#Example Usage: makeFlipable(player)



# MOVE AN OBJECT (constant speed) LEFT OR RIGHT ON KEY PRESS
func move(direction,obj):
    var move_speed = 5
	if direction == 'right':
		obj.set_pos(Vector2(obj.get_pos()[0] + move_speed,obj.get_pos()[1]))
	if direction == 'left':
		obj.set_pos(Vector2(obj.get_pos()[0] - move_speed,obj.get_pos()[1]))

# Example Usage:
#if Input.is_action_pressed("ui_right"):
    #move('right')
#elif Input.is_action_pressed("ui_left"):
    #move('left')



# CHANGE TO LEVEL ON BUTTON PRESS:
func changeLevel(btn,lvl):
    if btn.is_pressed():
        get_tree().change_scene("res://"+lvl+".scn")

# Example Usage: changeLevel(menu_button,'Menu')
# This checks for a scene in the resources folder
# Must run under the _process function



# MAKE AN OBJECT JUMP ON KEY PRESS
# comming soon...


# LOOP AN ANIMATED SPRITE (TO BE TESTED)
var frames = self.get_sprite_frames()

func loopAnimation(x,d):
	# Increment the elapsed time (seconds)
	dt = dt + d
	# I don't like the .1 for speed, so I could change this to dt = dt + delta*10, and set speed to 1.
	# I will leave it for demonstration purposes

	# If the elapsed time is greater than one frame...
	if(dt > speed):
		# And if the current frame is equal to the last frame minus 1 (second to last frame)...
		if(x.get_frame() == frames.get_frame_count() -1):
			# Set the frame of this sprite to the first frame
			x.set_frame(0)
		# Otherwise...
		else:
    	# Set the current frame to the next frame
        	x.set_frame(x.get_frame() + 1)

		# If you want the sprite to translate (as if walking forward), if it is a walking animation of course:
		#x.set_pos(Vector2(x.get_pos().x + 1,x.get_pos().y))

		# Now, reset the elapsed time
		dt = 0
#Example Usage: loopAnimation(bird,delta)
# Use under _process() function, and pass in delta as second argument



# PRELOAD A SCENE FOR SCENE ISTANCING
# First we preload (or load beforehand) the scene we would like to load to this scene.
var cube = preload('res://Levels/Cube.xml')

func _ready():
	# We create an instance/copy of that scene
	var cube_instance = cube.instance()
	# And we add it as a child of this node.
	add_child(cube_instance)
# Now run the game!



# LOAD RESOURCES WITH FILE DIALOG
extends FileDialog
var frame

func _ready():
	# Set the mode to open files
	# MODE_OPEN_FILE = 0
	set_mode(0)
	set_process(true)
	connect("confirmed",self,'print_path')
	frame = get_parent().get_node("TextureFrame")


func print_path():
	print(get_current_path())
	var res =  ResourceLoader.load(get_current_file())
	print(res)
	frame.set_texture(res)


# ADDING RESOURCES TO THE SCENE WITH PRESS OF BUTTON
extends Button

var resource = 'res://icon.png'

func _ready():
	connect('pressed',self,'load_asset')

func load_asset():
	var res = ResourceLoader.load(resource)
	print(res)
	var txt_btn = TextureButton.new()
	txt_btn.set_normal_texture(res)
	get_parent().add_child(txt_btn) #add a new button the the scene
	# New Button added to scene!


# IVENTORY ITEMS
extends HButtonArray

var editor
var icon
var frame


func _ready():
	set_process(true)
	editor = get_node("LineEdit")
	frame = TextureFrame.new()


func _process(delta):
	# Icon equals the selected button's icon
	var icon = get_button_icon(get_selected())
	# Set the text of the line edit node to the text of the button (captialized).
	editor.set_text('Inventory item '+ str(get_button_text(get_selected()).capitalize())+' was selected. Choose another...')
	# Set the texture of a frame object to the texture of the icon
	frame.set_texture(icon)
	# Add the texture frame as a child of the root node (which happens to be the parent node of this HButtonArray node)
	get_parent().add_child(frame)
	# Set the position of that frame to the mouse_position in the viewport
	frame.set_pos(get_viewport().get_mouse_pos())

	if chosen('corn'):
		print('corn chosen')
	if chosen('wheat'):
		print('wheat chosen')
	if chosen('coins'):
		print('coins chosen')
	if chosen('reputation'):
		print('reputation chosen')
	if chosen('hey'):
		print('hey chosen')


# Returns true if the text of the selected button is equal to x
func chosen(x):
	return get_button_text(get_selected()) == x


	# LOOK FROM 3D CAMERA
#__________________________

extends Camera

var sensitivity = 20

func _ready():
	set_process(true)
	print(get_translation())

func _process(delta):
	var projection = project_ray_normal(get_viewport().get_mouse_pos())
	#print(projection)
	var mouse_2d = get_viewport().get_mouse_pos()
	#print(mouse_2d)
	var mouse_3d = unproject_position(projection)
	#print(mouse_3d)
	look_at(projection*sensitivity,Vector3(0,1,0))



# FLY AROUND CAMERA


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
