extends RigidBody2D


var timer


func _ready():
	set_process(true)
	timer = Timer.new()
	timer.set_wait_time(.2)
	#timer.start()
	#timer.set_autostart(true)
	timer.connect('timeout',self,'hop')


func hop():
	set_axis_velocity(Vector2(0,-200))


func _process(delta):
	print(timer.get_time_left())
	

