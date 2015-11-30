
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_key_pressed(81) or Input.is_key_pressed(16777217):
		get_tree().quit()
	if Input.is_key_pressed(82):
		get_tree().reload_current_scene()
