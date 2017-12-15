tool
extends Node


const Util = preload("terrain_utils.gd")

const CHUNK_SIZE = 16
const MAX_TERRAIN_SIZE = 1024

class Chunk:
	var mesh_instance = null
	var body = null
	var pos = Vector2(0,0)

export(int, 0, 1024) var terrain_size = 0 setget set_terrain_size, get_terrain_size
export(Material) var material = null setget set_material, get_material
export var smooth_shading = true setget set_smooth_shading
export var quad_adaptation = false setget set_quad_adaptation
export var generate_colliders = false setget set_generate_colliders

var _data = []
var _normals = []

var _chunks = []
var _chunks_x = 0
var _chunks_y = 0
var _dirty_chunks = {}
var _undo_chunks = {}


func _get_property_list():
	return [
		# We just want to hide the following properties
		{
			"name": "_data",
			"type": TYPE_ARRAY,
			"usage": PROPERTY_USAGE_STORAGE
		}
	]


func _ready():
	# !!!
	# TODO MEGA WARNINGS OF THE DEATH:
	# - exporting an array will load it in COW mode!!! this will break everything!!!
	# - reloading the script makes data LOST FOREVER
	# UGLY FIX, remove asap when Godot will be fixed, it severely impacts loading performance on huge terrains
	_data = Util.clone_grid(_data)
	
	_on_terrain_size_changed()
	set_process(true)


func get_terrain_size():
	return terrain_size

func set_terrain_size(new_size):
	if new_size != terrain_size:
		if new_size > MAX_TERRAIN_SIZE:
			new_size = MAX_TERRAIN_SIZE
			print("Max size reached, clamped at " + str(MAX_TERRAIN_SIZE) + " for your safety :p")
		terrain_size = new_size
		#print("Setting terrain_size to " + str(terrain_size))
		_on_terrain_size_changed()


func get_material():
	return material

func set_material(new_material):
	if new_material != material:
		material = new_material
		for y in range(0, _chunks.size()):
			var row = _chunks[y]
			for x in range(0, row.size()):
				var chunk = row[x]
				chunk.mesh_instance.set_material_override(material)


func set_smooth_shading(smooth):
	if smooth != smooth_shading:
		smooth_shading = smooth
		_force_update_all_chunks()


func set_quad_adaptation(enable):
	if enable != quad_adaptation:
		quad_adaptation = enable
		_force_update_all_chunks()

# Direct data access for better performance.
# If you want to modify the data through this, don't forget to set the area as dirty
func get_data():
	return _data


func _on_terrain_size_changed():
	var prev_chunks_x = _chunks_x
	var prev_chunks_y = _chunks_y
	
	_chunks_x = Util.up_div(terrain_size, CHUNK_SIZE)
	_chunks_y = Util.up_div(terrain_size, CHUNK_SIZE)
	
	if is_inside_tree():
		
		Util.resize_grid(_data, terrain_size+1, terrain_size+1, 0)
		Util.resize_grid(_normals, terrain_size+1, terrain_size+1, Vector3(0,1,0))
		Util.resize_grid(_chunks, _chunks_x, _chunks_y, funcref(self, "_create_chunk_cb"), funcref(self, "_delete_chunk_cb"))
		
		for key in _dirty_chunks.keys():
			if key.mesh_instance == null:
				_dirty_chunks.erase(key)
		
		# The following update code is here to handle the case where terrain size
		# is not a multiple of chunk size. In that case, not-fully-filled edge chunks may be filled
		# and must be updated.
		
		# Set chunks dirty on the new edge of the terrain
		for y in range(0, _chunks.size()-1):
			var row = _chunks[y]
			_set_chunk_dirty(row[row.size()-1])
		if _chunks.size() != 0:
			var last_row = _chunks[_chunks.size()-1]
			for x in range(0, last_row.size()):
				_set_chunk_dirty(last_row[x])
		
		# Set chunks dirty on the previous edge
		if _chunks_x - prev_chunks_x > 0:
			for y in range(0, prev_chunks_x-1):
				var row = _chunks[y]
				_set_chunk_dirty(row[prev_chunks_x-1])
		if _chunks_y - prev_chunks_y > 0:
			var prev_last_row = _chunks[prev_chunks_y-1]
			for x in range(0, prev_last_row.size()):
				_set_chunk_dirty(prev_last_row[x])
		
		_update_all_dirty_chunks()


func _delete_chunk_cb(chunk):
	chunk.mesh_instance.queue_free()
	chunk.mesh_instance = null


func _create_chunk_cb(x, y):
	#print("Creating chunk (" + str(x) + ", " + str(y) + ")")
	var chunk = Chunk.new()
	chunk.mesh_instance = MeshInstance.new()
	chunk.mesh_instance.set_name("chunk_" + str(x) + "_" + str(y))
	chunk.mesh_instance.set_translation(Vector3(x,0,y) * CHUNK_SIZE)
	if material != null:
		chunk.mesh_instance.set_material_override(material)
	chunk.pos = Vector2(x,y)
	add_child(chunk.mesh_instance)
	
	# This makes the chunks visible in editor, however they would be saved,
	# which would be much less memory-efficient than keeping just the heightfield.
	#if get_tree().is_editor_hint():
	#	chunk.mesh_instance.set_owner(get_tree().get_edited_scene_root())
	
	_set_chunk_dirty(chunk)
	#update_chunk(chunk)
	return chunk

# Call this just before modifying the terrain
func set_area_dirty(tx, ty, radius, mark_for_undo=false):
	var cx_min = (tx - radius) / CHUNK_SIZE
	var cy_min = (ty - radius) / CHUNK_SIZE
	var cx_max = (tx + radius) / CHUNK_SIZE
	var cy_max = (ty + radius) / CHUNK_SIZE
	
	for cy in range(cy_min, cy_max+1):
		for cx in range(cx_min, cx_max+1):
			if cx >= 0 and cy >= 0 and cx < _chunks_x and cy < _chunks_y:
				_set_chunk_dirty_at(cx, cy)
				if mark_for_undo:
					var chunk = _chunks[cy][cx]
					if not _undo_chunks.has(chunk):
						var data = extract_chunk_data(cx, cy)
						_undo_chunks[chunk] = data


func extract_chunk_data(cx, cy):
	var x0 = cx * CHUNK_SIZE
	var y0 = cy * CHUNK_SIZE
	var cell_data = Util.grid_extract_area_safe_crop(_data, x0, y0, CHUNK_SIZE, CHUNK_SIZE)
	var d = {
		"cx": cx,
		"cy": cy,
		"data": cell_data
	}
	return d


func apply_chunks_data(chunks_data):
	for cdata in chunks_data:
		_set_chunk_dirty_at(cdata.cx, cdata.cy)
		var x0 = cdata.cx * CHUNK_SIZE
		var y0 = cdata.cy * CHUNK_SIZE
		Util.grid_paste(cdata.data, _data, x0, y0)

# Get this data just after finishing an edit action
func pop_undo_redo_data():
	var undo_data = []
	var redo_data = []
	
	for k in _undo_chunks:
		
		var undo = _undo_chunks[k]
		undo_data.append(undo)
		
		var redo = extract_chunk_data(undo.cx, undo.cy)
		redo_data.append(redo)
		
		# Debug check
		#assert(not Util.grid_equals(undo.data, redo.data))
		
	_undo_chunks = {}
	
	return {
		undo = undo_data,
		redo = redo_data
	}


func _set_chunk_dirty_at(cx, cy):
	_set_chunk_dirty(_chunks[cy][cx])

func _set_chunk_dirty(chunk):
	_dirty_chunks[chunk] = true


func _process(delta):
	_update_all_dirty_chunks()


func _update_all_dirty_chunks():
	for chunk in _dirty_chunks:
		update_chunk_at(chunk.pos.x, chunk.pos.y)
	_dirty_chunks.clear()


func _force_update_all_chunks():
	for y in range(0, _chunks.size()):
		var row = _chunks[y]
		for x in range(0, row.size()):
			update_chunk(row[x])


func world_to_cell_pos(wpos):
	#wpos -= _mesh_instance.get_translation()
	return Vector2(int(wpos.x), int(wpos.z))


func cell_pos_is_valid(x, y):
	return x >= 0 and y >= 0 and x <= terrain_size and y <= terrain_size


#func generate_terrain():
#	for y in range(_data.size()):
#		var row = _data[y]
#		for x in range(row.size()):
#			row[x] = 2.0 * (cos(x*0.2) + sin(y*0.2))


func update_chunk_at(cx, cy):
	var chunk = _chunks[cy][cx]
	update_chunk(chunk)

func update_chunk(chunk):
	var mesh = _generate_mesh_at(chunk.pos.x * CHUNK_SIZE, chunk.pos.y * CHUNK_SIZE, CHUNK_SIZE, CHUNK_SIZE)
	chunk.mesh_instance.set_mesh(mesh)


# This function is the most time-consuming one in this tool.
func _generate_mesh_at(x0, y0, w, h):
	var st = SurfaceTool.new()
	
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	#st.add_smooth_group(true)
	
	#print("Updating normals data (" + str(x0) + ", " + str(y0) + ", " + str(w) + ", " + str(h) + ")")
	#_debug_print_actual_size(_normals, "normals")
	if smooth_shading:
		_update_normals_data_at(x0, y0, w+1, h+1)
	
	var max_y = y0 + w
	var max_x = x0 + h
	
	if max_y >= terrain_size:
		max_y = terrain_size
	if max_x >= terrain_size:
		max_x = terrain_size
	
	var uv_scale = Vector2(1.0/terrain_size, 1.0/terrain_size)
	
	for y in range(y0, max_y):
		var row = _data[y]
		var normal_row = _normals[y]
		for x in range(x0, max_x):
			
			var p00 = Vector3(x-x0, row[x], y-y0)
			var p10 = Vector3(x+1-x0, row[x+1], y-y0)
			var p01 = Vector3(x-x0, _data[y+1][x], y+1-y0)
			var p11 = Vector3(x+1-x0, _data[y+1][x+1], y+1-y0)
			
			var uv00 = Vector2(x, y) * uv_scale
			var uv10 = Vector2(x+1, y) * uv_scale
			var uv11 = Vector2(x+1, y+1) * uv_scale
			var uv01 = Vector2(x, y+1) * uv_scale
			
			# TODO This is where optimization becomes a pain.
			# Find a way to use arrays instead of interleaved data. SurfaceTool is bad at this...
			# What if we don't want UVs? AAAAAAAAAAAAAAHHH
			# See? In C++, you do a lookup table. In GDScript, you don't, because it's TOO DAMN SLOW :D
		
			var reverse_quad = quad_adaptation and abs(p00.y - p11.y) > abs(p10.y - p01.y)
			
			if smooth_shading:
				
				var n00 = normal_row[x]
				var n10 = normal_row[x+1]
				var n01 = _normals[y+1][x]
				var n11 = _normals[y+1][x+1]
				
				if reverse_quad:
					# 01---11
					#  |\  |
					#  | \ |
					#  |  \|
					# 00---10
					
					st.add_normal(n00)
					st.add_uv(uv00)
					st.add_vertex(p00)
					
					st.add_normal(n10)
					st.add_uv(uv10)
					st.add_vertex(p10)
					
					st.add_normal(n01)
					st.add_uv(uv01)
					st.add_vertex(p01)
		
					st.add_normal(n10)
					st.add_uv(uv10)
					st.add_vertex(p10)
					
					st.add_normal(n11)
					st.add_uv(uv11)
					st.add_vertex(p11)
					
					st.add_normal(n01)
					st.add_uv(uv01)
					st.add_vertex(p01)
					
				else:
					# 01---11
					#  |  /|
					#  | / |
					#  |/  |
					# 00---10
					
					st.add_normal(n00)
					st.add_uv(uv00)
					st.add_vertex(p00)
					
					st.add_normal(n10)
					st.add_uv(uv10)
					st.add_vertex(p10)
					
					st.add_normal(n11)
					st.add_uv(uv11)
					st.add_vertex(p11)
		
					st.add_normal(n00)
					st.add_uv(uv00)
					st.add_vertex(p00)
					
					st.add_normal(n11)
					st.add_uv(uv11)
					st.add_vertex(p11)
					
					st.add_normal(n01)
					st.add_uv(uv01)
					st.add_vertex(p01)
			
			else:
				if reverse_quad:
					st.add_uv(uv00)
					st.add_vertex(p00)
					
					st.add_uv(uv10)
					st.add_vertex(p10)
					
					st.add_uv(uv01)
					st.add_vertex(p01)
		
					st.add_uv(uv10)
					st.add_vertex(p10)
					
					st.add_uv(uv11)
					st.add_vertex(p11)
					
					st.add_uv(uv01)
					st.add_vertex(p01)
				
				else:
					st.add_uv(uv00)
					st.add_vertex(p00)
					
					st.add_uv(uv10)
					st.add_vertex(p10)
					
					st.add_uv(uv11)
					st.add_vertex(p11)
		
					st.add_uv(uv00)
					st.add_vertex(p00)
					
					st.add_uv(uv11)
					st.add_vertex(p11)
					
					st.add_uv(uv01)
					st.add_vertex(p01)
					
	# When smoothing is active, we can't rely on automatic normals,
	# because they would produce seams at the edges of chunks,
	# so instead we generate the normals from the actual terrain data
	if not smooth_shading:
		st.generate_normals()

	st.index()
	var mesh = st.commit()
	return mesh


func get_terrain_value(x, y):
	if x < 0 or y < 0 or x >= terrain_size or y >= terrain_size:
		return 0.0
	return _data[y][x]


func get_terrain_value_worldv(pos):
	#pos -= _mesh_instance.get_translation()
	return get_terrain_value(int(pos.x), int(pos.z))

func position_is_above(pos):
	return pos.y > get_terrain_value_worldv(pos)


func _calculate_normal_at(x, y):
	#var center = get_terrain_value(x,y)
	var left = get_terrain_value(x-1,y)
	var right = get_terrain_value(x+1,y)
	var fore = get_terrain_value(x,y+1)
	var back = get_terrain_value(x,y-1)
	
	return Vector3(left - right, 2.0, back - fore).normalized()

func _update_normals_data_at(x0, y0, w, h):
	if x0 + w > terrain_size:
		w = terrain_size - x0
	if y0 + h > terrain_size:
		h = terrain_size - y0
	var max_x = x0+w
	var max_y = y0+h
	for y in range(y0, max_y):
		var row = _normals[y]
		for x in range(x0, max_x):
			row[x] = _calculate_normal_at(x,y)

# This is a quick and dirty raycast, but it's enough for edition
func raycast(origin, dir):
	if not position_is_above(origin):
		return null
	var pos = origin
	var unit = 1.0
	var d = 0.0
	var max_distance = 800.0
	while d < max_distance:
		pos += dir * unit
		if not position_is_above(pos):
			return pos - dir * unit
		d += unit
	return null


func set_generate_colliders(gen_colliders):
	if generate_colliders != gen_colliders:
		generate_colliders = gen_colliders
		_on_generate_colliders_changed()


func _on_generate_colliders_changed():
	if not is_inside_tree():
		return
	
	for cy in range(0, _chunks.size()):
		var row = _chunks[cy]
		for cx in range(0, row.size()):
			var chunk = row[cx]
			if generate_colliders:
				if chunk.body == null:
					# TODO
					pass
			else:
				if chunk.body != null:
					chunk.body.queue_free()



