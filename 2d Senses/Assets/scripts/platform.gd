
extends StaticBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)

func _process(delta):
	set_constant_linear_velocity(Vector2(-100,0))


