
extends Node2D


var sfx
var player

func _ready():
	set_process(true)
	sfx = get_node('SFX')
	sfx.play('playground_welcome')
	player = get_node("Man")
	print(self)
	
func _process(delta):
	if Input.is_key_pressed(KEY_Q) or Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()


func _on_Pause_pressed():
	get_tree().set_pause(true)


func _on_Unpause_pressed():
	get_tree().set_pause(false)
# The reason this unpause works is because the "Unpause" button has it's pause mode set to process. Check the Inspector.
# I had to look at the "Pause" demo to finally figure it out. 
