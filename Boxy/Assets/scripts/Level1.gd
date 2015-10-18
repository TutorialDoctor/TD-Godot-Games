extends Node2D
var boxy_animation
var boxy
var boxy_girl
var ray
var speed = 200
var restart_line

var samples

func _ready():
	set_process(true)
	
	boxy_animation = get_node("AnimationPlayer")
	boxy = get_node("Boxy")
	boxy.set_contact_monitor(true)
	boxy.set_max_contacts_reported(true)
	boxy_girl = get_node("Boxy Girl")
	
	ray = get_node("Boxy/RayCast2D")
	ray.add_exception(boxy)	
	
	samples = get_node("SamplePlayer")
	
	restart_line = get_node("Restart Line")

func _process(delta):
	boxy.set_angular_velocity(0)
	if on_ground():
		if Input.is_action_pressed("ui_up"):
			if not boxy_animation.is_playing():
				boxy_animation.play('squash')
				boxy.set_axis_velocity(Vector2(0,-1000))
				samples.play('jump')
	
	if on_ground():
		if Input.is_action_pressed('ui_left'):
			boxy.set_axis_velocity(Vector2(-speed,0))
		if Input.is_action_pressed('ui_right'):
			boxy.set_axis_velocity(Vector2(speed,0))
	
	if boxy_girl in boxy.get_colliding_bodies():
		print('Hey boxy girl!')
		#get_tree().change_scene('res://Levels/Menu.xml')
	
	if restart_line in boxy.get_colliding_bodies():
		get_tree().reload_current_scene()

func on_ground():
	return ray.is_colliding()
