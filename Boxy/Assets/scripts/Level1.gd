extends Node2D

var boxy_animation
var boxy
var ray
var speed = 200
var btn_restart
var btn_quit
var sounds

func _ready():
	set_process(true)
	btn_restart = get_node("Boxy/Controls/RESTART")
	btn_restart.connect('pressed',self,'restart_game')
	
	btn_quit = get_node("Boxy/Controls/QUIT")
	btn_quit.connect('pressed',self,'quit_game')
	
	boxy_animation = get_node("AnimationPlayer")
	boxy = get_node("Boxy")
	ray = get_node("Boxy/RayCast2D")
	ray.add_exception(boxy)	
	
	sounds = get_node("SamplePlayer")

func _process(delta):
	boxy.set_angular_velocity(0)
	if on_ground():
		if Input.is_action_pressed("ui_up"):
			if not boxy_animation.is_playing():
				boxy_animation.play('squash')
				boxy.set_axis_velocity(Vector2(0,-1000))
				sounds.play('jump')
	
	if on_ground():
		if Input.is_action_pressed('ui_left'):
			boxy.set_axis_velocity(Vector2(-speed,0))
		if Input.is_action_pressed('ui_right'):
			boxy.set_axis_velocity(Vector2(speed,0))
	
func on_ground():
	return ray.is_colliding()

func restart_game():
	get_tree().reload_current_scene()
	
func quit_game():
	get_tree().quit()