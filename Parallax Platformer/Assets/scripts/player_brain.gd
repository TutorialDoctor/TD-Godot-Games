
# Almost There!

extends RigidBody2D

var player
var feet
var jump_height = 400
export var move_speed = 200
var player2
var samples
var restart_line

export var next_level = ''

func _ready():
	set_process(true)
	feet = get_node("Feet")
	feet.add_exception(self) # The player
	set_mode(2)
	player2 = get_parent().get_node("Player 2")
	samples = get_node("/root/Node2D/Samples")
	
	restart_line = get_parent().get_node("Restart Line")
	
	# For collision detection
	set_contact_monitor(true)
	set_max_contacts_reported(1)


func _process(delta):
	if feet.is_colliding():
		print('colliding!!')

	if feet.is_colliding():
		if Input.is_action_pressed("ui_up"):
			set_axis_velocity(Vector2(0,-jump_height))
			#samples.play('jump')

	
	if feet.is_colliding():
		if Input.is_action_pressed("ui_right"):
			set_axis_velocity(Vector2(move_speed,0))
		if Input.is_action_pressed("ui_left"):
			set_axis_velocity(Vector2(-move_speed,0))

	
	if Input.is_key_pressed(81): # Q to quit. Need the scancode.
		get_tree().quit()
	
	if Input.is_key_pressed(82):
		get_tree().reload_current_scene()
	
	if not samples.is_active():
		if player2 in get_colliding_bodies():
			print('I can collide with stuff now!!')
			#get_tree().change_scene(next_level)
			samples.play('hello')
	
	if restart_line in get_colliding_bodies():
		get_tree().reload_current_scene()
		