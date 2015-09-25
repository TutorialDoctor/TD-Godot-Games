# This is a 3D demo for the Godot engine.
# By The Tutorial Doctor
# Thu Sep 24 10:25:40 EDT 2015
# wwww.tutorialdoctor.weebly.com
# @TutorialDoctor

extends Camera

# Member variables
var rise_speed = .1
var node = null
var zoom_slider = null
var height_slider = null
var pos_default = null

# Setup and Game Loop
func _ready():
	set_process(true)
	node = get_parent().get_node("Mary/Position3D")
	zoom_slider = get_parent().get_node('Control/VSlider')
	zoom_slider.set_min(10)
	zoom_slider.set_max(90)
	zoom_slider.set_val(30)
	
	pos_default = node.get_translation() # default position of the position node
	
	height_slider = get_parent().get_node('Control/cam_height_slider')
	height_slider.set_min(0)
	height_slider.set_max(pos_default[1])
	height_slider.set_val(30)

func _process(delta):
	set('fovy',zoom_slider.get_val())
	raise()
	target(node)
	moveTarget(node)


# CUSTOM FUNCTIONS (3D)

# Zoom in to node "x" (Not in use)
func zoom(x):
	# If the parameter is true...
	if x:
		# If up arrow is pressed
		if Input.is_action_pressed("ui_up"):
			# Set the field of view (along the y axis) to 30)
			set('fovy',30)
		else:
			# Set the field of view (along the y axis) to 55)
			set('fovy',55)
	else: 
		return

# Raise and lower 3d camera
func raise():
	# If the "rise" input mapping is pressed...
	if Input.is_action_pressed('rise'):
		# Set the translation to the current translation with the component incremented by the rise_speed
		set_translation(Vector3(get_translation()[0],get_translation()[1]+rise_speed,get_translation()[2]))
	# And do the opposite for the "lower" input mapping
	if Input.is_action_pressed("lower"):
		set_translation(Vector3(get_translation()[0],get_translation()[1]-rise_speed,get_translation()[2]))

# Look at (target) node "n"
func target(n):
		look_at(n.get_translation(),Vector3(0,1,0))

# Moves node "x" along the y axis
func moveTarget(x):
	x.set_translation(Vector3(x.get_translation()[0],height_slider.get_val(),x.get_translation()[2]))