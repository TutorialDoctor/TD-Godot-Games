
extends Node2D


var sfx

func _ready():
	set_process(true)
	sfx = get_node('SFX')
	sfx.play('playground_welcome')

func _process(delta):
	if Input.is_key_pressed(81) or Input.is_key_pressed(16777217):
		get_tree().quit()
	if Input.is_key_pressed(82):
		get_tree().reload_current_scene()

