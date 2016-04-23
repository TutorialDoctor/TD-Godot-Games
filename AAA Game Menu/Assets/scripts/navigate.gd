
extends VButtonArray

# Google "creative commons music" for free music.
# http://freemusicarchive.org/genre/Instrumental/
# Ars Sonor "Jasmina's Song (Mona Lisa Overdrive Mix for Jasmina Olsson)""In Search of Balance (Among the Shadows)" 
# Blue Dot Sessions "Stillness""Speakeasy" Soundtrack, Minimalism, Instrum
#Drone, Industrial, Ambient
# grab_focus() is important

var samples

func _ready():
	set_process_input(true)
	grab_focus() # put focus on the button array
	samples = get_parent().get_node("SamplePlayer")
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
		samples.play('shotgun')
	if event.is_action_pressed("ui_down"):
		samples.play("Blip_Select3")
	elif event.is_action_pressed("ui_up"):
		samples.play("Blip_Select3")

