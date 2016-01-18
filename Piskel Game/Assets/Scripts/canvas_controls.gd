
extends CanvasLayer

var btn_info
var window_info
var rich_label
var text = """[center][u]Controls[/u][/center]

W - Jump
A - Move left
S -  Move right
D - Duck
R - Restart Level
Q or Esc - Quit Game
Up_Arrow - Shock

[center][u]Credits[/u][/center]

By the Tutorial Doctor.

All art made with Piskel, a free cross-platform pixel art app.
"""

func _ready():
	btn_info = get_node("Button")
	window_info = btn_info.get_children()[0]
	rich_label = get_node("Button/WindowDialog/RichTextLabel")
	
	btn_info.connect('pressed',self,'show_info')
	
	rich_label.set_bbcode(text+'\n'+str(get_tree().get_current_scene().get_filename()))

func show_info():
	window_info.popup()