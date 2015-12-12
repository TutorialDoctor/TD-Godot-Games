
extends CanvasLayer

var btn
var window
var label

func _ready():
	window = get_node("Button/WindowDialog")
	label = get_node("Button/WindowDialog/RichTextLabel")
	btn = get_node("Button")

	btn.connect('pressed',self,'show_up')

func show_up():
	window.show()


