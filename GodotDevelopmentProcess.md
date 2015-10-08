
# Godot Development Process

*By the [@TutorialDoctor](https://twitter.com/TutorialDoctor)*

*October 8, 2015*

## 1. Create the project folder
- Assets
	- sprites
		- static
		- animated
	- scripts
	- sounds
	- fonts
	- meshes
		- obj
		- collada
	- maps
- Levels

## 2. Create a new Godot project in the folder
- Create a scene with root node and save it (3 scenes)
	- Control (GUI)
	- Node2D (2D objects)
	- Spatial (3D objects)
- Save main scene (.xml)
- Look at project folder
	- config
	- icon

## 3. Add Assets to the project folder
- Piskel
	- png
- MagicaVoxel
	- obj
	- png
- Blender/Wings3D
	- obj
	- collada
- Pixelmator
- Audacity
	- wav
	- ogg

## 4. Add children nodes to root nodes to levels
### Inspect their properties and documentation
- Control
	- Button
	- Color Picker
	- Window
	- Slider
	- Check Box
	- Switch
- Node 2D
	- Sprite
	- Animated Sprite
	- Animation Player
	- Particles2D
	- SamplePlayer (wav)
	- Stream Player (ogg)
	- RayCast2D
	- CollisionShape2D
- Spatial
	- Lights
	- Camera
	- MeshInstance
	- Sprite 3D
	- TestCube
	- Particles
	- RayCast
	- CollisionShape

## 5. Scripting

### Beginners
- Basics
	- Variables
		- outside main functions (available everywhere)
		- inside _ready()
		- inside _process())
		- exporting
	- Printing
	- Functions
		- custom
		- _ready()
		- _process()
		- _fixed_process()
		- get_node()
		- get_parent()
		- get_tree()
		- get()
		- set()
	- Api
	
- GUI
	- Change level with a button press
- 2D Game
	- Add force to 2d rigidBody with key press
- 3D Game
	- Add force to 3D rigidBody with key press

### Intermediate
Coming soon...
### Advanced
Coming soon...
