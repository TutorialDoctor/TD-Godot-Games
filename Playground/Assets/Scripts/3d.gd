
extends Spatial

var children

func _ready():
	set_process(true)
	_setup()


func _process(delta):
	pass

func _setup():
	children = get_children()