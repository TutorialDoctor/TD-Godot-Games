extends RigidBody2D
# By the Tutorial Doctor
# Sun Oct 18 22:22:10 EDT 2015

# Apply this script to a RigidBody2D node and it will be ready to move!
# This node must have a CollisionShape2D, RayCast2D, and SamplePlayer node as children for everything to work.
# All else is optional
#------------------------------------------------------------
var player
var feet
var speed = 200
var ground
var computer 
var eyes
var label
var sight_distance = 500
var player_sprite
export var next_level = ''

#------------------------------------------------------------

#------------------------------------------------------------
func _ready():
	set_process(true)
	setup()
#------------------------------------------------------------

#------------------------------------------------------------
func setup():
	player = self
	player.set_contact_monitor(true)
	player.set_max_contacts_reported(true)
	player.set_mode(2)
	player_sprite = get_node("Sprite")
	feet = get_node("RayCast2D")
	feet.add_exception(player)
	ground = get_parent().get_node("Ground")
	computer = get_parent().get_node("Computer")
	label = get_node("Label")
	eyes = get_node("Eyes")
	eyes.add_exception(player)
	# I want to scale music volume by the distance between a null music object)
#------------------------------------------------------------

# CUSTOM FUNCTIONS 
# Just making things easier to read and use
#------------------------------------------------------------
# Returns true if PhysicsBody a is colliding with PhysicsBody b
func is_collision_betweeen(a,b):
	if b in a.get_colliding_bodies():
		return true
	else:
		return false

# Move object x left and right with actions a and b (repsectively)
func move_with(x,a,b):
	if on_ground(feet):
		if Input.is_action_pressed(a):
			x.set_axis_velocity(Vector2(-speed,0))
			eyes.set_cast_to(Vector2(-sight_distance,0))
			player_sprite.set('flip_h',true)
		if Input.is_action_pressed(b):
			x.set_axis_velocity(Vector2(speed,0))
			eyes.set_cast_to(Vector2(sight_distance,0))
			player_sprite.set('flip_h',false)

# Add upward force to RigidBody x using action a
func jump_with(x,a):
	if on_ground(feet):
		if Input.is_action_pressed(a):
			x.set_axis_velocity(Vector2(0,-1000))
			play_sample('SamplePlayer','jump')

# Quits the game with the press of a key (if x is true)
func quit_game(x):
	if x == true:
		if Input.is_key_pressed(16777217) or Input.is_key_pressed(81): 
			get_tree().quit()

# Reload the game with the press of a key (x is true)
func reload_game(x):
	if x == true:
		if Input.is_key_pressed(82):
			get_tree().reload_current_scene()

# Returns true if RayCast2D node x is colliding with something
func on_ground(x):
	return x.is_colliding()

func next_level():
	get_tree().change_scene('res://Levels/'+ next_level)

# Play sample b from SamplePlayer a
func play_sample(a,b):
	self.get_node(a).play(b)

# Returns true if object x (by name) is seen (if they eyes raycast node is collidng with it).
func see(x):
	if eyes.is_colliding():
		if eyes.get_collider().get_name() == x:
			print('I see '+str(eyes.get_collider().get_name()))
			label.set_text('I see ' + str(eyes.get_collider().get_name()))
			return true
		else:
			false

# Returns true if object b feels object a (if the two physics objects are colliding). Also prints it.
func feel(a,b):
	if is_collision_betweeen(b,a):
		print('I feel ' + a.get_name())
		return true
	else:
		return false
#-------------------------------------------------------

#------------------------------------------------------------
func _process(delta):
	move_with(player,'ui_left','ui_right')
	jump_with(player,'ui_up')
	reload_game(true)
	quit_game(true)
	
	if feel(computer,player):
		player.set_axis_velocity(Vector2(0,-200))
		play_sample('SamplePlayer','jump')
	
	see('Computer')
	see('Platform')
	feel(ground,player)
	
	#see(eyes)
#------------------------------------------------------------
