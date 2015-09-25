
extends Button

var samp = null

func _ready():
	samp = get_parent().get_node("SamplePlayer")

func _process(delta):
	if is_pressed():
		samp.play(samp_tack)


