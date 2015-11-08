
extends Sprite

var starting_pos
export var running_length = 3000
export var move_speed = 10

func _ready():
	set_process(true)
	starting_pos = get_pos()

func _process(delta):
	move_local_x(move_speed)
	if get_global_pos().x > running_length:
		set_pos(starting_pos)

