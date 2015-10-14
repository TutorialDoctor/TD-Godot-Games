# Godot Development Process

*By the [@TutorialDoctor](https://twitter.com/TutorialDoctor))*

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

## 2. Create a new Godot project and scenes
- Create a scene with root node and save it (3 scenes)
	- Control (GUI)
	- Node2D (2D objects)
	- Spatial (3D objects)
- Save main scene (.xml)
- Look at project folder
	- config
	- icon

## 3. Add Assets to the project folder
- Piskel (Pixel Art)
	- png
- MagicaVoxel (Voxel Art)
	- obj
	- png
- Blender/Wings3D (3D Art)
	- obj
	- collada
- Pixelmator (Bitmap and Vector art) $
- Audacity (Sound editing)
	- wav
	- ogg

## 4. Add nodes to scenes
### Inspect their properties and documentation
- Control (GUI)
	- Button
	- Color Picker
	- Window
	- Slider
	- Check Box
	- Switch
	- File Dialog
- Node 2D (2D Games)
	- Sprite (game graphics)
	- Animated Sprite (characters)
	- Animation Player 
	- Particles2D (visual effects)
	- SamplePlayer (wav)
	- Stream Player (ogg)
	- RayCast2D (vector collision)
	- CollisionShape2D (shape collision)
	- Horizontal Button Array (inventory)
- Spatial (3D Games)
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
		- connect()
		- new()
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

# Video Tutorials
- [Game From Scratch]()
- [Andy]()
- [Tractor Trouble]()

# Demos To Preview
- Floppy Bird
- Model Viewer
- Dojo Ninjas
- Story Board
- Big Battle
- 2D Lighting
- Truck Town
- Platformer
- Inventory