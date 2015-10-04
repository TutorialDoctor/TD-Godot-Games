extends RigidBody2D

# Apply this script to a RigidBody2D node that has a Sprite, CollisioinShape2D, Raycast2D, and SamplePlayer as children.
# Sprite is the image of the rigidbody. CollisionShape2D is the collision boundaries of the rigidbody. Raycast2D is what checks for collisions.
# SamplePlayer is what plays a sound when the rigidbody jumps.

var box = null
var sprite = null
var ray = null
var sound = null


func _ready():
	setup()
	set_process(true)
	

func _process(delta):
	makeItMove(self,sprite,ray,sound)


# CUSTOM FUNCTIONS
#This function sets up variables without having to do it directly in _ready() function
func setup():
	box = get_node(self) #The RigidBody object
	sprite = get_node() #The Sprite (Image) for the object
	ray = get_node() #The RayCast2D (Detetction) node
	ray.add_exception(ray) #Don't let it collide with itself
	ray.set_enabled(true) #Enable the raycast node it
	sound = get_node() #The jump sound


func makeItMove(obj,sprite,ray,sound):
	# Don't let the object spin as much (make it damp)
	obj.set_angular_damp(100)
	# If right arrow is pressed...
	if Input.is_action_pressed("ui_right"):
		# set the y axis velocity to 300
		obj.set_axis_velocity(Vector2(300,0))
		# and flip the sprite horizontally
		sprite.set('flip_h',false)
	if Input.is_action_pressed("ui_left"):
		obj.set_axis_velocity(Vector2(-300,0))
		sprite.set('flip_h',true)
	
	if ray.is_colliding():
		if Input.is_action_pressed("ui_up"):
			obj.set_axis_velocity(Vector2(0,-300))
			sound.play('samp_bip')
	
	# Just for testing (can be deleted)
	print(ray.is_colliding())
# END CUSTOM FUNCTIONS