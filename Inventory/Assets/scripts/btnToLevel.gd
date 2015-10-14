extends Button
# I will make this button change scenes

# You can export variables to the Inspector for easy access.
export var scene = 'res://Levels/Level1.xml'

func _ready():
	set_process(true)


func _process(delta):
	# buttons have an is_pressed() function to check if it is pressed or not. It returns true of false (a boolean)
	if is_pressed():
		# the get_tree() function gets the highest parent of the scene. We can use the change_scene() method to change scenes
		# The highest parent is the viewport
		get_tree().change_scene(scene)

# SUMMARY:
	# Export variables
	# Move up node hierarchy
	# Change scenes
	