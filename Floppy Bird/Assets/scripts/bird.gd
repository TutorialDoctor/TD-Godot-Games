
extends RigidBody2D

var ray = null
var sound = null
func _ready():
	set_process(true)
	ray = get_node("ray")
	ray.add_exception(self)
	sound = get_parent().get_node("SamplePlayer")

func _process(delta):
	# If the left mouse button or up arrow is pressed...
	if Input.is_mouse_button_pressed(1) or Input.is_action_pressed("ui_up"):
		# Set the axis velocity on the y axis to -200
		set_axis_velocity(Vector2(0,-400))
	# If the ray node is colliding with something..
	if ray.is_colliding():
		print(ray.get_collider())
		#sound.play('punch',true)
		get_tree().change_scene('res://Levels/Menu.xml')

