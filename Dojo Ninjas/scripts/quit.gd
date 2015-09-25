
extends Button

func _ready():
	connect('pressed',self,'quit')

func quit():
	var confirm = get_parent().get_node("ConfirmationDialog")
	confirm.set('visibility/visible',true)
	#get_tree().quit()
