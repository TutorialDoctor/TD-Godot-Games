# YESS! IT WORKS! MUAHAHAHAHA!
# Color picker changes dress color. -TD

# This is a 3D demo for the Godot engine.
# By The Tutorial Doctor
# Thu Sep 24 10:25:40 EDT 2015
# wwww.tutorialdoctor.weebly.com
# @TutorialDoctor

extends Spatial

var rot_speed = .1
var dress = null
var picker = null
var picker_color = null
var dress_material = null
var dress_picker = null
var hair_material = null
var hair_picker = null
var hair = null


func _ready():
	set_process(true)
	dress = get_node("MaryDress.001")
	hair = get_node("MaryHair.001")
	dress_picker = get_parent().get_node("Control/ColorPickerButton")
	dress_material= dress.get('geometry/material_override') 
	
	hair_material = hair.get('geometry/material_override')
	hair_picker = get_parent().get_node("Control/hair_picker")

	
func _process(delta):
	rotateObject(self)
	recolor(dress_material,dress_picker)
	recolor(hair_material,hair_picker)


# CUSTOM FUNCTIONS
# Rotate object "x"
func rotateObject(x):
	if Input.is_action_pressed("left"):
		x.set_rotation(Vector3(x.get_rotation()[0],x.get_rotation()[1]-rot_speed,x.get_rotation()[2]))

	if Input.is_action_pressed("right"):
		x.set_rotation(Vector3(x.get_rotation()[0],x.get_rotation()[1]+rot_speed,x.get_rotation()[2]))
	

# Recolor material "x" with color picker "y"
func recolor(x,y):
	picker_color = y.get_color()
	x.set_parameter(0,picker_color) 	#PARAMETER_DIFFUSE = 0