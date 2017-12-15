
# This script is mainly used for testing terrain edition in a running game

extends Node


const Terrain = preload("res://addons/zylann.terrain/terrain.gd")
const Brush = preload("res://addons/zylann.terrain/terrain_brush.gd")

onready var _camera = get_parent()
onready var _terrain = get_parent().get_parent().get_node("Terrain")
onready var _cursor = get_node("TestCube")
onready var _brush = Brush.new()


func _ready():
	_brush.generate(4)
	set_process_input(true)
	set_process(true)


func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed:
		# TODO Private function access is temporary!
		if event.button_index == BUTTON_WHEEL_UP:
			_brush.set_radius(_brush.get_radius()+1)
		elif event.button_index == BUTTON_WHEEL_DOWN:
			_brush.set_radius(_brush.get_radius()-1)


func _process(delta):
	var origin = _camera.get_translation()
	var dir = _camera.get_transform().basis * Vector3(0,0,-1)
	var hit_pos = _terrain.raycast(origin, dir)
	
	if hit_pos != null:
		_cursor.set_translation(hit_pos)
		
		var up = Input.is_mouse_button_pressed(BUTTON_LEFT)
		var down = Input.is_mouse_button_pressed(BUTTON_RIGHT)
		
		if up or down:
			if Input.is_key_pressed(KEY_X):
				var factor = 4.0*delta
				_brush.paint_world_pos(_terrain, hit_pos, Brush.MODE_SMOOTH)
			else:
				if down:
					_brush.paint_world_pos(_terrain, hit_pos, Brush.MODE_SUBTRACT)
				else:
					_brush.paint_world_pos(_terrain, hit_pos, Brush.MODE_ADD)

