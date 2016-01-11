
extends Area2D

var speed = 300
var rot_speed = 10
var bullet = preload('res://Scenes/bullet.xscn')
var tip
var path
var path_speed = 500


func _ready():
	set_process(true)
	tip = get_node("Position2D")
	path = get_parent()


func _process(delta):
	var dir = Vector2()
	if Input.is_action_pressed("left"):
		dir+=Vector2(-1,0)
	if Input.is_action_pressed("right"):
		dir+=Vector2(1,0)
	if Input.is_action_pressed("ui_down"):
		dir+=Vector2(0,1)
	if Input.is_action_pressed("ui_up"):
		dir+=Vector2(0,-1)
	translate(dir*delta*speed)
	
	if Input.is_action_pressed("ui_left"):
		rotate(delta*rot_speed)
	
	if Input.is_action_pressed("ui_right"):
		rotate(delta*-rot_speed)
		
	var bullet_intance = bullet.instance()
	add_child(bullet_intance)
	bullet_intance.set_pos(tip.get_pos())
	
	path.set_offset(path.get_offset()+path_speed*delta)


