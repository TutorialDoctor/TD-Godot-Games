tool
extends MeshInstance


export var step = 16 setget set_step, get_step
var color = Color(1,0,0)
var count = 16


func _ready():
	update_mesh()


func get_step():
	return step

func set_step(new_step):
	if step != new_step:
		step = new_step
		if is_inside_tree():
			update_mesh()

func update_mesh():
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_LINES)

	st.add_color(color)
	
	for x in range(0, count):
		st.add_vertex(Vector3(x * step, 0, 0))
		st.add_vertex(Vector3(x * step, 0, count * step))
		st.add_vertex(Vector3(0, 0, x * step))
		st.add_vertex(Vector3(count * step, 0, x * step))

	set_mesh(st.commit())
