
extends Node

var node2d
var control
var sfx

var resources
var editor 

# Runs once on the first frame of the game 
func _ready():
	set_process(true)
	_setup()
	display(scene())
	display(resource('icon'))
	display(self)
	display(name(control))
	display(get_node("Control/btn_clear").get_type())
	sfx.play('playground_welcome')
	
# Runs every input event
func _input(event):
	pass
# Runs every game frame
func _process(delta):
	pass
# Runs ever physics frame
func _fixed_process(delta):
	pass
# Runs when the tree/game/applicatioin is entered (this is similar to an "application" in other programs)
func _enter_tree():
	pass
# Runs when the tree/game/application is exited 
func _exit_tree():
	pass


# MY FUNCTIONS
func _setup():
	node2d = get_node("Node2D")
	control = get_node("Control")
	resources = get_node("ResourcePreloader")
	editor = get_node("Control/TextEdit")
	editor.set_text('Output: \n')
	editor.set_readonly(true)
	sfx = get_node('SFX')


func resource(x):
	return resources.get_resource(x)

func scene():
	return get_filename().get_file()

func display(x):
	editor.set_text(editor.get_text() + '\n' + str(x))

func name(x):
	return x.get_name()
