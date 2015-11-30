extends Node2D
# By the Tutorial Doctor
# Sun Oct 18 22:22:10 EDT 2015
var current_level
#------------------------------------------------------------
# First, make variables for all of the things that will be in your game
var player
var player_animation
var player_samples
var computer
var computer_samples
var ray
export var move_speed = 200
var ground
var hearts
var kissable = true
var timer
var player_sprite
var label
export var height_speed = -1000
# This variable is exported so we can change it for each level
export var next_level = ''
#------------------------------------------------------------


# The _ready() function is where we will set up everything.
#------------------------------------------------------------
func _ready():
	# Make sure to always enable the _process() function. This is your game loop.
	set_process(true)
	current_level = get_tree().get_current_scene().get_filename()
	print(current_level)
	label = Label.new()
	label.set_text(current_level)
	# Now we set nodes to those variables we created:
	# Get the player node. It is a RigidBody node.
	# The player node should have Sprite,CollisionShape2D, and RayCast2D nodes as children
	player = get_node("Player")
	# Get the player's animation node. It is an AnimationPlayer node
	player_animation = get_node("AnimationPlayer")
	# Make the player able to monitor collision
	player.set_contact_monitor(true)
	# Also you have to make sure all collisions are reported
	player.set_max_contacts_reported(true)
	# The two steps above could be eliminated, but you need them both to do collision detection for Rigidbodies
	# Setting the mode of the player rigidbody to 2 makes it not rotate unecessarily 
	player.set_mode(2)
	# If you want the player to have sound effects, you have to store them in a sample player node
	player_samples = get_node("SamplePlayer")
	player.add_child(label)
	
	# The computer node is just a duplicate of the Player node.
	computer = get_node("Computer")
	# Give it the same mode so that it doesn't rotate.
	computer.set_mode(2)
	computer_samples = get_node("SamplePlayer 2")
	
	# The player's Raycast2D node checks for collision in a certain direction
	ray = get_node("Player/RayCast2D")
	# So that the RayCast doesn't detect collisions with the player we need to make the player an exception.
	# Now the ray will not detect collision with the player node.
	ray.add_exception(player)

	# This node is a StaticBody. We will check collisions with it to restart the level.
	ground = get_node("Ground")
	
	# This is a particle system. We will make it emitt when the player collides with the computer.
	hearts =  get_node("Computer/Hearts")
	
	# Timer nodes are used to do things once a certain amount of time has passed. 
	timer = get_node("Timer")
	
	# Player Sprite
	player_sprite = get_node("Player/Sprite")
	#player_sprite = get_node("Player/Sprite 2")
#------------------------------------------------------------


# Custom functions make life easier sometimes
#------------------------------------------------------------
# This function returns true if the RayCast2D node is colliding with something, otherwise it returns false
func on_ground():
	return ray.is_colliding()

# This function goes to the next level. You can use the connect() function to connect a signal to this function
func next_level():
	get_tree().change_scene(next_level)
# END CUSTOM FUNCTIONS
#------------------------------------------------------------


# This is the game loop or draw() function of Godot.
#------------------------------------------------------------
func _process(delta):
	# If the RayCast2D is colliding with something (if it is on_ground()...
	if on_ground():
		# And if the "up" action is pressed...
		if Input.is_action_pressed("ui_up"):
			# And if the player_animation AnimationPlayer is not playing (already)...
			if not player_animation.is_playing():
				# Then play the "squash" animation,
				player_animation.play('squash') #not created yet
				# Set the axis_velocity on the y axis to -1000,
				player.set_axis_velocity(Vector2(0,height_speed))
				# And play the "jump" sample sound
				player_samples.play('jump')
	
	# Also, if the RayCast2D is colliding with something (if it is on_ground()...
	if on_ground():
		# And if the "left" action is pressed...
		if Input.is_action_pressed('ui_left'):
			# Set the axis_velocity on the x axis to minus the speed variable.
			player.set_axis_velocity(Vector2(-move_speed,0))
			#player_sprite.set('flip_h',true)
		# And if the "right" action is pressed...
		if Input.is_action_pressed('ui_right'):
			# Set the axis_velocity on the x axis the speed variable.
			player.set_axis_velocity(Vector2(move_speed,0))
			#player_sprite.set('flip_h',false)
	
	
	# If the computer RigidBody node is in the player's colliding_bodies (it is an array)...
	if computer in player.get_colliding_bodies():
		# And if kissable is equal to true (this will allow us to turn off the kiss sound later)...
		if kissable:
			# Print something,
			print('Hey boxy girl!')
			# Play the "kiss" sample of the computer sample's SamplePlayer node,
			computer_samples.play('kiss1')
			# Also play the "femyawn_ed" sample,
			computer_samples.play('femyawn_ed')
			# And set the hearts paricle system's config/emitting property to true,
			hearts.set('config/emitting',true)
			# Make kissalbe = false as well (this will disable this whole conditional)
			kissable = false
			# Lastly, start the timer (It is set to 3 seconds) and will count down from that,
			timer.start()
			# And connect the "timeout" signal of the timer the next_level() function.
			timer.connect('timeout',self,'next_level')
			# Whew!!!
	
	# If the ground is part of the player's colliding bodies...
	if ground in player.get_colliding_bodies():
		# reload the current scene
		get_tree().reload_current_scene()
	
	# If the "esc" or "Q" buttons are pressed...
	if Input.is_key_pressed(16777217) or Input.is_key_pressed(81): 
	#16777217 is the scancode for the escape key under @GlobalScope in the API
		# Quit the game
		get_tree().quit()
	# If the "R" key is pressed... 
	if Input.is_key_pressed(82):
	#82 is the scancode for the 'R' key under @GlobalScope in the API
		# Reload the scene
		get_tree().reload_current_scene()
		
			
# AND THAT IS ALL YOU NEED FOR A PLATFORMER BASE GAME!!!

# Duplicate this level and move the platforms around and you have a new level. 
# Be sure to change the Next Level property we exported for each level.