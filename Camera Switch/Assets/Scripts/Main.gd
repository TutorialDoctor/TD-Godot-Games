
extends Spatial

var camera


func _ready():
	camera = get_node("Cameras").get_children()
	
	for c in camera:
		c.set('far',1000)


func select_camera(x):
	camera[x].make_current()

func _on_Button_pressed():
	select_camera(0)


func _on_Button1_pressed():
	select_camera(1)


func _on_Button2_pressed():
	select_camera(2)


func _on_Button3_pressed():
	select_camera(3)
