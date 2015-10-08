
extends Button

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	connect('pressed',self,'load_asset')

func load_asset():
	pass
