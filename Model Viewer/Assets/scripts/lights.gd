
extends DirectionalLight

var light_intensity_slider = null
var light_color_picker = null

func _ready():
	set_process(true)
	light_intensity_slider = get_parent().get_parent().get_node("Control/slider_light")
	light_intensity_slider.set_val(0)
	light_intensity_slider.set_min(0)
	light_intensity_slider.set_max(5)
	
	light_color_picker = get_parent().get_parent().get_node("Control/light_color")
	
func _process(delta):
	set('params/energy',light_intensity_slider.get_val())
	set('colors/diffuse',light_color_picker.get_color())
	