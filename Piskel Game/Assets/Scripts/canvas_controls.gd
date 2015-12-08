
extends CanvasLayer

var btn_info
var window_info

func _ready():
	btn_info = get_node("Button")
	window_info = btn_info.get_children()[0]
	
	btn_info.connect('pressed',self,'show_info')

func show_info():
	window_info.popup()