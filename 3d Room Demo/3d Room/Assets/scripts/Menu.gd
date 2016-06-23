extends Control

# DECLARING VARIABLES FOR LATER USE

# Create a new sample library
var library = SampleLibrary.new()
# Create a new sample player
var player = SamplePlayer.new()
# Load a .wav file as a resource
var res = ResourceLoader.load("res://3d Room/Assets/sounds/samples/Select3.wav")



# This function runs as soon as the game starts
func _ready():

	# CREATE GUI ELEMENTS PROGRAMATICALLY
	# Create a new button
	var new_button = Button.new()
	# Set the "text" property of the button to "Press Me!"
	new_button.set("text","Press Me!")
	# Add the new button to this node (Control) as a child
	self.add_child(new_button)


	# MOVING ELEMENTS
	# Set the position of the new button to the current position of the new button plus (200,200)
	new_button.set_pos(new_button.get_pos()+Vector2(200,200))
	# (200,200) is a 2D vector that represents the X and Y axes.


	# ROTATING ELEMENTS
	# Set the rotation of the new button to the current rotation of the new button plus 90 degrees
	new_button.set_rotation(new_button.get_rotation()+deg2rad(90))
	# Rotation is calculated in radians so we can use the deg2rad() function to convert degrees into radians
	# If you wanted to use radians it would be PI radians. Godot has a built-in constant for PI.
	#new_button.set_rotation(new_button.get_rotation()+PI)


	# SCALING ELEMENTS
	# Set the scale of the new button to the current scale of the new button plus (1,1).
	new_button.set_scale(new_button.get_scale()+Vector2(1,1))
	# (1,1) is a 2D Vector that represents the X and Y axes

	# CONNECTING BUTTONS TO EVENTS/SIGNALS
	# connect the "pressed" event/signal of the new button to a function in this/self node named "display"
	new_button.connect("pressed",self,'display')
	# When you press the button, the Display() function triggers. Try it!

	# PLAYING SOUNDS ON SIGNALS
	# We can play a sound from a sample library upon the pressed signal by adding the resource variable to the sample library
	# We also set the library we created earler as the sample library for the sample player.
	library.add_sample('sound',res)
	player.set_sample_library(library)

	# Lets make it so that we can process code every frame
	set_process(true)


func display():
	print('You pressed the button mate!')
	player.play('sound')


# All frame-by-frame processing is done in the _process(function)
# It takes an optional argument (delta) which is the amount of time that has passed between the current frame and the last frame
# This argument, if used with computations makes for smoother frame-rates
# delta also be used to convert frames into seconds
func _process(delta):
	print('Processing..') # prints every frame at a target frame-rate of 60fps

	# CONTINUOUS ROTATION
	# Get the first child of the Control and rotate it by its current rotation PI/delta radians.
	# The first child of the Contorl is the button we created. get_child() returns an index of an array.
	get_child(0).set_rotation(get_child(0).get_rotation()+PI*delta)
	# I chose PI/delta because using a value like PI/96, although slow, is not ideal.


	# SCALE UP THEN DOWN
