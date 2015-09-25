
extends Button
var samp = null

func _ready():
	connect('pressed',self,'showSettings')
	samp = get_parent().get_parent().get_node("Sounds/Voice")

func showSettings():
	var settings = get_parent().get_node("menu_Settings")
	settings.set('visibility/visible',true)
	samp.play('japanese 1')
	#get_parent().set('visibility/opacity',0)


