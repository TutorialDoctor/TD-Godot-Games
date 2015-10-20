extends Node2D
var boxy_animation
var boxy
var boxy_girl
var ray
var speed = 200
var restart_line
var boxy_samples
var boxy_girl_samples
var hearts
var kissable = true
var timer
export var next_level = ''

func _ready():
	set_process(true)
	boxy_animation = get_node("AnimationPlayer")
	boxy = get_node("Boxy")
	boxy.set_contact_monitor(true)
	boxy.set_max_contacts_reported(true)
	boxy.set_mode(2)
	boxy_girl = get_node("Boxy Girl")
	boxy_girl.set_mode(2)
	ray = get_node("Boxy/RayCast2D")
	ray.add_exception(boxy)	
	boxy_samples = get_node("SamplePlayer")
	boxy_girl_samples = get_node("SamplePlayer 2")
	restart_line = get_node("Restart Line")
	hearts =  get_node("Boxy Girl/Hearts")
	timer = get_node("Timer")

func _process(delta):
	if on_ground():
		if Input.is_action_pressed("ui_up"):
			if not boxy_animation.is_playing():
				boxy_animation.play('squash')
				boxy.set_axis_velocity(Vector2(0,-1000))
				boxy_samples.play('jump')
	
	if on_ground():
		if Input.is_action_pressed('ui_left'):
			boxy.set_axis_velocity(Vector2(-speed,0))
		if Input.is_action_pressed('ui_right'):
			boxy.set_axis_velocity(Vector2(speed,0))
	
	if boxy_girl in boxy.get_colliding_bodies():
		if kissable:
			print('Hey boxy girl!')
			boxy_girl_samples.play('kiss1')
			boxy_girl_samples.play('femyawn_ed')
			hearts.set('config/emitting',true)
			kissable = false
			timer.start()
			timer.connect('timeout',self,'next_level')

	
	if restart_line in boxy.get_colliding_bodies():
		get_tree().reload_current_scene()
	
	if Input.is_key_pressed(16777217) or Input.is_key_pressed(81): 
	#16777217 is the scancode for the escape key under @GlobalScope in the API
		get_tree().quit()
	if Input.is_key_pressed(82):
	#82 is the scancode for the 'R' key under @GlobalScope in the API
		get_tree().reload_current_scene()

func on_ground():
	return ray.is_colliding()

func next_level():
	get_tree().change_scene(next_level)
