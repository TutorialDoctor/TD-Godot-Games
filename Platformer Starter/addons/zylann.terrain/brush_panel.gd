tool
extends Control

signal brush_shape_changed
signal brush_size_changed
signal brush_opacity_changed
signal brush_mode_changed
signal ask_save_to_image

onready var _shape_selector = get_node("shapes")

onready var _size_line_edit = get_node("params/size/LineEdit")
onready var _size_slider = get_node("params/size/slider")

onready var _opacity_line_edit = get_node("params/opacity/LineEdit")
onready var _opacity_slider = get_node("params/opacity/slider")

onready var _mode_selector = get_node("params/mode_selector")

onready var _save_to_image_button = get_node("save_to_image")

var _first_ready = false

func _ready():
	pass
	# TODO !!! HOTFIX: Godot calls _ready() twice in scenes instanced in the editor!
	if not _first_ready:
		_first_ready = true
		
		_build_shape_selector()
		
		# TODO Make a reusable slider
		_size_slider.connect("value_changed", self, "_on_size_slider_value_changed")
		_size_line_edit.connect("text_entered", self, "_on_size_line_edit_entered")

		_opacity_slider.connect("value_changed", self, "_on_opacity_slider_value_changed")
		_opacity_line_edit.connect("text_entered", self, "_on_opacity_line_edit_entered")
		
		_mode_selector.connect("button_selected", self, "_on_mode_selector_button_selected")
		
		_save_to_image_button.connect("pressed", self, "_on_save_to_image_button_clicked")


func _build_shape_selector():
	_shape_selector.set_same_column_width(true)
	_shape_selector.set_max_columns(0)
	
	var base_dir = get_filename().get_base_dir()
	var brush_dir = base_dir + "/brushes"
	
	var brush_paths = get_file_list(brush_dir, "png")
	for path in brush_paths:
		var brush_tex = load(brush_dir + "/" + path)
		if brush_tex != null:
			_shape_selector.add_icon_item(brush_tex)
	
	_shape_selector.connect("item_selected", self, "_on_shape_selected")


func _on_shape_selected(index):
	var tex = _shape_selector.get_item_icon(index)
	emit_signal("brush_shape_changed", tex)


func _on_size_slider_value_changed(value):
	emit_signal("brush_size_changed", value)
	_size_line_edit.set_text(str(value))


func _on_size_line_edit_entered(text):
	var size = text.to_int()
	_size_slider.set_value(size)


func _on_opacity_slider_value_changed(value):
	emit_signal("brush_opacity_changed", value / 100.0)
	_opacity_line_edit.set_text(str(value))


func _on_opacity_line_edit_entered(text):
	var opacity = text.to_int()
	_opacity_slider.set_value(opacity)


func _on_mode_selector_button_selected(button):
	emit_signal("brush_mode_changed", button)


func _on_save_to_image_button_clicked():
	# TODO Use FileDialog, I have no idea how yet
	emit_signal("ask_save_to_image", "terrain_test.png")


static func get_file_list(dir_path, exts):
	if typeof(exts) == TYPE_STRING:
		exts = [exts]
	var dir = Directory.new()
	var open_code = dir.open(dir_path)
	if open_code != 0:
		print("Cannot open directory! Code: " + str(open_code))
		return null
	var list = []
	dir.list_dir_begin()
	for i in range(0, 1000):
		var file = dir.get_next()
		if file == "":
			break
		if not dir.current_is_dir():
			var file_ext = file.extension()
			for ext in exts:
				if ext == file_ext:
					list.append(file)
					break
	return list
