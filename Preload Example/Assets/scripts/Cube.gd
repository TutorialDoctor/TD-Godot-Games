extends Spatial

var y = 0
var x = 0
var z = 0
var s = 1 # scale

func _ready():
	# Initialization here
	print('A script from the cube scene is running!')
	set_process(true)

func _process(delta):
	y = y + .1
	x = x + .1
	z = z + .1
	set_rotation(Vector3(x,y,0))
	
	if Input.is_action_pressed("ui_up"):
		set_scale(Vector3(s+.5,s+.5,s+.5))

	
	if Input.is_action_pressed("ui_down"):
		set_scale(Vector3(s-.5,s-.5,s-.5))	