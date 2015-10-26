extends FileDialog
var frame


func _ready():
	# Set the mode to open files
	# MODE_OPEN_FILE = 0 
	set_mode(0)
	connect("confirmed",self,'print_path')
	frame = get_parent().get_node("TextureFrame")


func print_path():
	print(get_current_path())
	var res =  ResourceLoader.load(get_current_file())
	print(res)
	frame.set_texture(res)
	# FINALLY!

# Only the icon.png file is working for me right now. hmmm
# Also title isn't changing

func show_dialog():
	set('visibility/visible',true)