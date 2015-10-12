extends Spatial
# First we preload the scene we would like to load to this scene. 
# This loads it into memeory
var cube = preload('res://Levels/Cube.xml')

func _ready():
	# We create an instance/copy of that scene
	var cube_instance = cube.instance()
	# And we add it as a child of this node.
	add_child(cube_instance)
# Now run the game and your cube scene appears in this scene!

# The original preloaded cube scene is loaded as a PackedScene. The instance() function unpacks it.
	print(cube_instance.get_children())

# Lights in the current scene will affect geometry in the loaded scene
# Scripts inside of the loaded scene will run also.
# The clear color under project settings resets to the default grey using this method. Bug?