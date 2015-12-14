
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

	if Input.is_key_pressed(80):
		get_tree().set_pause(true)
	if Input.is_key_pressed(85):
		get_tree().set_pause(false)


func _on_Pause_pressed():
	get_tree().set_pause(true)



func _on_Unpause_pressed():
	get_tree().set_pause(false)
# The reason this unpause works is because the "Unpause" butoon has it's pause mode set to process. Check the Inspector.
# I had to look at the "Pause" demo to finally figure it out. 