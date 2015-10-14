
extends LineEdit

export var placeholder = ''

func _ready():
	connect("focus_enter",self,'clear_placeholder')
	connect("focus_exit",self,"add_placeholder")

func clear_placeholder():
	set_text('')

func add_placeholder():
	set_text(placeholder)