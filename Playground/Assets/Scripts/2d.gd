
extends Node2D

var children
var player
var sprite
var feet 
var ground
var move_speed = 100
var jump_force = 300
export var can_jump = true

func _ready():
	set_process(true)
	_setup()
	player = children[0]
	sprite = get_node('Player/Sprite')
	ground = children[1]
	feet = player.get_node('Feet')
	feet.add_exception(player)


func _process(delta):
	jump()
	move()


func _setup():
	children = get_children()


func jump():
	if can_jump:
		if feet.is_colliding():
			if Input.is_action_pressed('ui_up'):
				player.set_axis_velocity(Vector2(0,-jump_force))
	else: 
		return

func move():
	if feet.is_colliding():
		if Input.is_action_pressed("ui_left"):
			player.set_axis_velocity(Vector2(-move_speed,0))
			sprite.set('flip_h',true)
		if Input.is_action_pressed("ui_right"):
			player.set_axis_velocity(Vector2(move_speed,0))
			sprite.set('flip_h',false)