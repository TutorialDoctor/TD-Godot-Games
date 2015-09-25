
extends Button

var samp = null

func _ready():
	samp = get_parent().get_parent().get_node("Sounds/Voice")
	connect('pressed',self,'playSound')


func playSound():
	samp.play('smp_dojoNinjas')
	#get_parent().set('visibility/opacity',0)


