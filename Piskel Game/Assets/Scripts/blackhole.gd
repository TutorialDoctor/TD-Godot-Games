
extends Sprite

# I neeed area2d to detect another area2d connected to the man
# This way the black hole will change the level

var hole
var player

func _ready():
	player = get_owner().get_node("Man")
	hole = get_node("Area2D")
	print(hole.is_monitoring_enabled())
	set_process(true)
	
	hole.connect("body_enter",self,'go',[player])

func _process(delta):
	pass

func go():
	print('going')