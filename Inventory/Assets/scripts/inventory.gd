extends HButtonArray

var editor 
var icon
var frame


func _ready():
	set_process(true)
	editor = get_node("LineEdit")
	frame = TextureFrame.new()


func _process(delta):
	# Icon equals the selected button's icon
	var icon = get_button_icon(get_selected())
	# Set the text of the line edit node to the text of the button (captialized).
	editor.set_text('Inventory item '+ str(get_button_text(get_selected()).capitalize())+' was selected. Choose another...')
	# Set the texture of a frame object to the texture of the icon
	frame.set_texture(icon)
	# Add the texture frame as a child of the root node (which happens to be the parent node of this HButtonArray node)
	get_parent().add_child(frame)
	# Set the position of that frame to the mouse_position in the viewport
	frame.set_pos(get_viewport().get_mouse_pos())

	if chosen('corn'):
		print('corn chosen')
	if chosen('wheat'):
		print('wheat chosen')
	if chosen('coins'):
		print('coins chosen')
	if chosen('reputation'):
		print('reputation chosen')
	if chosen('hey'):
		print('hey chosen')


# Returns true if the text of the selected button is equal to x
func chosen(x):
	return get_button_text(get_selected()) == x


