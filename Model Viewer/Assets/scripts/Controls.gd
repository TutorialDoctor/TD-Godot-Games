
extends Control

# Member Variables
var dressPicker = null
var hairPicker = null
var voices = null
var op_btn = null

func setup():
	dressPicker = get_node("ColorPickerButton")
	hairPicker = get_node("hair_picker")
	voices = get_parent().get_node("Sounds/Voice")
	dressPicker.connect('pressed',self,'dressOpinion')
	hairPicker.connect('pressed',self,'hairOpinion')
	op_btn = get_node("Opinion Button")
	op_btn.connect('pressed',self,'opinion')

func _ready():
	setup()
	set_process(true)


func dressOpinion():
	voices.play('chooseDress')
	
func hairOpinion():
	voices.play('chooseHair')

func opinion():
	voices.play('nice')