
extends Control

var children
var editor
var button
var title
var btn_reload
var btn_clear
var line_edit
var status
var player 
var feet
var window_commands
var btn_commands
var title_2
var node2d
var sfx
var window_info
var btn_info



func _ready():
	set_process(true)
	_setup()
	btn_reload.connect('pressed',self,'reload')
	btn_commands.connect('pressed',self,'display_commands')
	btn_info.connect('pressed',self,'display_info')


func _process(delta):
	enable_commands(true)


# MY FUNCTIONS
func _setup():
	children = get_children()
	editor = children[0]
	btn_clear = children[1]
	btn_reload = children[2]
	title = children[3]
	line_edit = children[4]
	status = children[5]
	title_2 = children[6]
	window_commands = children[7]
	btn_commands = children[8]
	btn_info = children[9]
	window_info = children[10]
	
	player = get_parent().get_node("Node2D/Player")
	feet = player.get_node('Feet')
	node2d = get_parent().get_node("Node2D")
	sfx = get_parent().get_node("SFX")

func reload():
	get_tree().reload_current_scene()
	

func enable_commands(x):
	if x == true:
		connect('jump','jump')
		connect('move left','move_left')
		connect('move right','move_right')
		connect('spin right','spin_right')
		connect('spin left','spin_left')
		connect('reload','restart')
		connect('stop','stop')
		connect('hide','hide')
		connect('show','show')
		connect('quit','quit_game')
		connect('date','get_date')
		connect('os','get_os')

	else:
		status.set_text('commands disabled')
		return


# Connect a command name of your choice to a function
# This makes it easy to add new commands
func connect(c,f):
	if line_edit.get_text()== c:
		status.set_text(c)
		call(f)

func display_commands():
	window_commands.popup()
	sfx.play('commands')

func display_info():
	window_info.popup()

# Command Functions
func jump():
	if feet.is_colliding():
		player.set_axis_velocity(Vector2(0,-node2d.jump_force))
func move_left():
	player.set_axis_velocity(Vector2(-node2d.move_speed,0))
func move_right():
	player.set_axis_velocity(Vector2(node2d.move_speed,0))	
func spin_right():
	player.set_angular_velocity(15)
func spin_left():
	player.set_angular_velocity(-15)
func restart():
	get_tree().reload_current_scene()
func stop():
	player.set_rot(0)
	player.set_angular_velocity(0)
func hide():
	player.set('visibility/opacity',0)
func show():
	player.set('visibility/opacity',1)
func quit_game():
	get_tree().quit()
func get_date():
	status.set_text(str(OS.get_date()))
func get_os():
	status.set_text(OS.get_name())

# Helper Functions
func help():
	print('helping...')