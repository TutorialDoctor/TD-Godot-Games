extends ParallaxLayer

func _ready():
	var viewport = get_viewport()
	var screensize = viewport.get_rect().size
	set_mirroring(Vector2(0, screensize.y))

