# This is a 3D demo for the Godot engine.
# By The Tutorial Doctor
# Thu Sep 24 10:25:40 EDT 2015
# wwww.tutorialdoctor.weebly.com
# @TutorialDoctor

extends Button

export var scene = ''

func _ready():
	connect('pressed',self,'change')

func change():
	get_tree().change_scene("res://Levels/"+scene+".scn")


