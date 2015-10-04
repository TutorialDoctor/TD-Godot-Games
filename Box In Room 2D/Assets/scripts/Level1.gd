extends Node2D

var box = null
var room = null
var box_Sprite = null
var box_ray = null
var btn_Restart = null
var label = null
var sound = null

func setup():
	box = get_node("Box")
	room = get_node("Room")
	box_Sprite = get_node("Box/box_Sprite")
	box_ray = get_node("Box/RayCast2D")
	box_ray.add_exception(box)
	box_ray.set_enabled(true)
	btn_Restart = get_node("Control/Button")
	btn_Restart.connect('pressed',self,'restart')
	label = get_node("Control/Label")
	label.set_text(get_tree().get_current_scene().get_filename())
	sound = get_node("SamplePlayer")

func restart():
	get_tree().reload_current_scene()


func makeItMove():
	box.set_angular_damp(100)
	if Input.is_action_pressed("ui_right"):
		box.set_axis_velocity(Vector2(300,0))
		box_Sprite.set('flip_h',false)
	if Input.is_action_pressed("ui_left"):
		box.set_axis_velocity(Vector2(-300,0))
		box_Sprite.set('flip_h',true)
	
	if box_ray.is_colliding():
		if Input.is_action_pressed("ui_up"):
			#box.apply_impulse(box.get_pos(),Vector2(0,box.get_pos()[1]*4).normalized())
			box.set_axis_velocity(Vector2(0,-300))
			sound.play('samp_bip')
	
	print(box_ray.is_colliding())
	
func _ready():
	setup()
	set_process(true)
	

func _process(delta):
	makeItMove()