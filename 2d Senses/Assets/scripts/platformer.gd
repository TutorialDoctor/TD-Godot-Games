extends Node2D
# By the Tutorial Doctor
# Sun Oct 18 22:22:10 EDT 2015
#------------------------------------------------------------
var player
var computer
var ray
var speed = 200
var ground
export var next_level = ''
#------------------------------------------------------------

#------------------------------------------------------------
func _ready():
	set_process(true)
	setup()
#------------------------------------------------------------

#------------------------------------------------------------
func on_ground():
	return ray.is_colliding()

func next_level():
	get_tree().change_scene(next_level)
	
func setup():
	player = get_node("Player")
	player.set_contact_monitor(true)
	player.set_max_contacts_reported(true)
	player.set_mode(2)
	computer = get_node("Computer")
	computer.set_mode(2)
	ray = get_node("Player/RayCast2D")
	ray.add_exception(player)
	ground = get_node("Ground")
# END CUSTOM FUNCTIONS
#------------------------------------------------------------

#------------------------------------------------------------
func _process(delta):
	if on_ground():
		if Input.is_action_pressed("ui_up"):
			player.set_axis_velocity(Vector2(0,-1000))
	
	if on_ground():
		if Input.is_action_pressed('ui_left'):
			player.set_axis_velocity(Vector2(-speed,0))
		if Input.is_action_pressed('ui_right'):
			player.set_axis_velocity(Vector2(speed,0))
	# if is_collision_between(computer,player):
		#pass
	#if is_collision_betweeen(ground,player):
		#pass

	if Input.is_key_pressed(16777217) or Input.is_key_pressed(81): 
		get_tree().reload_current_scene()

func is_collision_betweeen(a,b):
	if a in b.get_colliding_bodies():
		return true
	else:
		return false