extends RigidBody2D

var collision_ray
var speed = 100

func _ready():
	set_process(true)
	collision_ray = get_node("RayCast2D")
	collision_ray.add_exception(self)
	self.set_contact_monitor(true)
	self.set_max_contacts_reported(true)
	self.set_mode(2)
	

func is_collision_betweeen(a,b):
	if b in a.get_colliding_bodies():
		return true
	else:
		return false

func move_with(x,a,b):
	if on_ground(collision_ray):
		if Input.is_action_pressed(a):
			x.set_axis_velocity(Vector2(-speed,0))
		if Input.is_action_pressed(b):
			x.set_axis_velocity(Vector2(speed,0))

func jump_with(x,a):
	if on_ground(collision_ray):
		if Input.is_action_pressed(a):
			x.set_axis_velocity(Vector2(0,-1000))

func on_ground(x):
	return x.is_colliding()


func _process(delta):
	pass