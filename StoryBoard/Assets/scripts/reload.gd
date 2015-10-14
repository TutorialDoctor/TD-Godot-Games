
extends Button


func _ready():
	connect('pressed',self,'quit')

func quit():
	get_tree().reload_current_scene()