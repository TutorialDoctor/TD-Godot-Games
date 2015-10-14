
extends Button

var resource = 'res://icon.png'

func _ready():
	connect('pressed',self,'load_asset')

func load_asset():
	var res = ResourceLoader.load(resource)
	print(res)
	var txt_btn = TextureButton.new()
	txt_btn.set_normal_texture(res)
	get_parent().add_child(txt_btn) #add a new button the the scene
	# New Button added to scene!

