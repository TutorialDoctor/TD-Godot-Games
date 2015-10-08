
extends HSlider

var animated_sprite = null


func _ready():
	set_process(true)
	animated_sprite = get_parent().get_node("AnimatedSprite")

func _process(delta):
	animated_sprite.set('delay',get_val())


