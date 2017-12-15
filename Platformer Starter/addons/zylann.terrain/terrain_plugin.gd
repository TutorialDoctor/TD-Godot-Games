tool
extends EditorPlugin

const Terrain = preload("terrain.gd")
const Brush = preload("terrain_brush.gd")
const Util = preload("terrain_utils.gd")

const TARGET_TYPE = "Terrain"

var current_object = null

var _pressed = false
var _brush = null
var _disable_undo_callback = false
var _panel = null


func _enter_tree():
	add_custom_type(TARGET_TYPE, "Node", Terrain, preload("icon.png"))
	
	_brush = Brush.new()
	_brush.set_undo_redo(true)
	
	# TODO Initial brush state doesn't match the GUI
	_panel = preload("brush_panel.tscn").instance()
	add_control_to_container(CONTAINER_SPATIAL_EDITOR_BOTTOM, _panel)
	_panel.connect("brush_size_changed", self, "_on_brush_size_changed")
	_panel.connect("brush_mode_changed", self, "_on_brush_mode_changed")
	_panel.connect("brush_shape_changed", self, "_on_brush_shape_changed")
	_panel.connect("brush_opacity_changed", self, "_on_brush_opacity_changed")
	_panel.connect("ask_save_to_image", self, "_on_ask_save_to_image")
	_panel.hide()


func _exit_tree():
	_panel.free()
	_panel = null
	
	remove_custom_type(TARGET_TYPE)


func _on_brush_size_changed(size):
	_brush.generate(size)


func _on_brush_opacity_changed(opacity):
	_brush.set_opacity(opacity)


func _on_brush_mode_changed(mode):
	_brush.set_mode(mode)


func _on_brush_shape_changed(tex):
	assert(tex extends ImageTexture)
	_brush.generate_from_image(tex.get_data())


func _on_ask_save_to_image(path):
	if current_object == null:
		return
	
	print("Saving terrain data as image '" + str(path) + "'")
	
	var data = current_object.get_data()
	var image = Image(current_object.terrain_size+1, current_object.terrain_size+1, false, Image.FORMAT_RGBA)
	
	var vrange = Util.grid_min_max(data)
	var vmin = vrange[0]
	var vmax = vrange[1]
	var max_amp = vmax - vmin
	
	for y in range(data.size()):
		var row = data[y]
		for x in range(row.size()):
			var h = row[x]
			h = (h - vmin) / max_amp
			image.put_pixel(x, y, Color(h,h,h))
	
	image.save_png(path)
	
	var normal_map_image_path = path.basename() + "_normal_map." + path.extension()
	var ndata = current_object._normals
	for y in range(0, ndata.size()):
		var row = ndata[y]
		for x in range(0, row.size()):
			var n = row[x] * 0.5 + Vector3(0.5, 0.5, 0.5)
			image.put_pixel(x, y, Color(n.x, n.y, n.z))
	image.save_png(normal_map_image_path)


func paint(camera, mouse_pos, mode=-1):
	var origin = camera.project_ray_origin(mouse_pos)
	var dir = camera.project_ray_normal(mouse_pos)
	
	var hit_pos = current_object.raycast(origin, dir)
	if hit_pos != null:
		_brush.paint_world_pos(current_object, hit_pos, mode)


func handles(object):
	return object extends Terrain


func edit(object):
	current_object = object


func make_visible(visible):
	if visible:
		_panel.show()
	else:
		_panel.hide()


func forward_spatial_input_event(camera, event):
	var captured_event = false
	
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == BUTTON_LEFT or event.button_index == BUTTON_RIGHT:
			captured_event = true
			if event.is_pressed():
				_pressed = true
			else:
				_pressed = false
				
				var data = current_object.pop_undo_redo_data()
				var ur = get_undo_redo()
				ur.create_action("Paint terrain")
				ur.add_undo_method(self, "_undo_paint", current_object, data.undo)
				ur.add_do_method(self, "_redo_paint", current_object, data.redo)
				# Callback is disabled because data is too huge to be executed a second time
				_disable_undo_callback = true
				ur.commit_action()
				_disable_undo_callback = false
	
	elif _pressed and event.type == InputEvent.MOUSE_MOTION:
		
		if _brush.get_mode() == Brush.MODE_ADD and Input.is_mouse_button_pressed(BUTTON_RIGHT):
			paint(camera, event.pos, Brush.MODE_SUBTRACT)
			captured_event = true
		
		elif Input.is_mouse_button_pressed(BUTTON_LEFT):
			paint(camera, event.pos)
			captured_event = true
	
	return captured_event


func _undo_paint(terrain, data):
	if _disable_undo_callback == false:
		terrain.apply_chunks_data(data)

func _redo_paint(terrain, data):
	if _disable_undo_callback == false:
		terrain.apply_chunks_data(data)

