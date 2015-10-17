extends StreamPlayer

func _ready():
# Sounds Setup
	#------------------------------------------------------------
	# Get the sound nodes
	#var sample = get_node("Sounds/SamplePlayer")
	# Sample players are used for sound effects (.WAV)
	# Add your sounds to Sample Library(12176). You can play sounds on top of each other by changing the "Voices" property.

	play()
    
	# Stream players are used for music (OGG,MPC)
	# Avoid mp3. you have to pay to use this format
	# Audacity can be used to convert to the prefered formats

# Sound Functions
#------------------------------------------------------------


