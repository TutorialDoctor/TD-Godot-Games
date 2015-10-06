extends Control
# Tue Oct  6 13:03:30 EDT 2015

# Notes:
# To get this to work I ran into several issues. Firstly, I followed the setup of the 3d in 2D example.
# I forgot I needed a light and a camera in the 3D scene.
# I had to make sure the ViewportSprite was set to the Viewport node, and that the Spatial node is parented to that Viewport node.
# Lastly, the sphere shape needed to have a FixedMaterial assigned before I could use get('geometry/material_override')

# Now that I have the base setup, I realize the process is simple:

# You make a 3d scene a child of a viewport node, which is a child of a 2D node. The sprite of that viewport is the viewport itself.

#The main properties in the Viewport node I think need to be enabled are "Render Target Enabled" "Clear on New Frame" and "Own World."

# No code is needed to show the 3d scene within the 2d scene. This code simple connects the color picker to the spehre.

# To-Do:
	# Rotating sphere preview
	# Rotating light source (or even changing it and it's color) This is easy as I have doen it in the Model Viewer project already.


var sphere = null
var diff_picker = null
var sphere_material = null
var picker_color = null
var spec_picker = null
var texture_frame = null

func _ready():
	set_process(true)
	sphere = get_node("PopupPanel/sphere_preview/Viewport/Spatial/Sphere")
	sphere_material = sphere.get('geometry/material_override')
	diff_picker = get_node("PopupPanel/diff_picker")
	spec_picker = get_node("PopupPanel/spec_picker")
	
	# It would be nice to load textures into a frame to view them, so this is how you do it.
	texture_frame = get_node("TextureFrame")
	texture_frame.set_texture(sphere_material.get_texture(0)) # Parameter 0 is the diffuse texture slot

func _process(delta):
	recolor(0,sphere_material,diff_picker)
	recolor(2,sphere_material,spec_picker)

# Recolors the property index of a meterial to the color of a color picker
# n is the index of the material, x is the material of the object, and y is the color picker node.
func recolor(n,x,y):
	picker_color = y.get_color()
	x.set_parameter(n,picker_color) 	#PARAMETER_DIFFUSE = 0



# ADDITIONAL FUNCTIONS YOU MIGHT WANT TO USE
#func set_properties():
	#control('morph/Eye',eye_slider)
	#control('morph/Jaw',jaw_slider)
	#control('morph/Nose',nose_slider)


# Controls property "a" with slider "b"
#func control(a,b):
	#suzanne.set(a,b.get_val())

# Recolor material "x" with color picker "y"


# Material Indices
#PARAM_DIFFUSE = 0  Diffuse Lighting (light scattered from surface).
#PARAM_DETAIL = 1  Detail Layer for diffuse lighting.
#PARAM_SPECULAR = 2  Specular Lighting (light reflected from the surface).
#PARAM_EMISSION = 3  Emission Lighting (light emitted from the surface)
#PARAM_SPECULAR_EXP = 4  Specular Exponent (size of the specular dot)
#PARAM_GLOW = 5  Glow (Visible emitted scattered light).
#PARAM_NORMAL = 6  Normal Map (irregularity map).
#PARAM_SHADE_PARAM = 7
#PARAM_MAX = 8  Maximum amount of parameters
