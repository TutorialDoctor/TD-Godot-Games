### Scene Layout
- Node 2d
	- Sprite
	- VButtonArray [s1]
		- Label = Start Game
		- Label = Options
		- Label = Credits
		- Label = Quit Game
	- StreamPlayer = sample.ogg
	- SamplePlayer = sample.wav

### VButtonArray

4 buttons with custom **Selected** and **Normal** states.

### Scripts

[s1]
<pre>
extends VButtonArray

# Google "creative commons music" for free music.
# http://freemusicarchive.org/genre/Instrumental/
# Ars Sonor "Jasmina's Song (Mona Lisa Overdrive Mix for Jasmina Olsson)""In Search of Balance (Among the Shadows)" 
#Drone, Industrial, Ambient
# grab_focus() is important

var samples

func _ready():
	set_process_input(true)
	grab_focus() # put focus on the button array
	samples = get_parent().get_node("SamplePlayer")
	

func _input(event):
	print(event.is_action_pressed("ui_accept"))
	if event.is_action_pressed("ui_down"):
		samples.play("Blip_Select3")
	elif event.is_action_pressed("ui_up"):
		samples.play("Blip_Select3")
</pre>