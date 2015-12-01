
extends Label

var kylei = "ky'Lei Burns"

# \n means "new line"
var credits = [
'PROGRAMMER\n\nThe Tutorial Doctor',
'ART\n\nThe Tutorial Doctor',
'VOICES\n\nKylei Burns',
'SOUND EDITING\n\nThe Tutorial Doctor'
]
var counter = 0
var music

func _ready():
	music = get_parent().get_node("Music")


func next_credit():
	# If the counter is less than the length/size of the credits array...
	if (counter < credits.size()):
		# Set the text of this label to the index of the counter...
		set_text(credits[counter])
		# and increment the counter.
		counter +=1
	# Otherwise...
	else:
		# Quit the game
		get_tree().reload_current_scene()
# This function is called by the Animation Player on the first frame.
