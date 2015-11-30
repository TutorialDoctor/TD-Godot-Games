extends RigidBody2D


var sprite
var feet
var sfx
var animations
var timer
export var move_speed = 0
export var jump_height = 0


func _ready():
	set_process(true)
	animations = get_node("Sprite/AnimationPlayer")
	sprite = get_node("Sprite")
	sfx = get_parent().get_node("SFX")
	feet = get_node("Feet")
	feet.add_exception(self)
	

func _process(delta):
	if Input.is_action_pressed("ui_down"):
		animations.play('duck')
	if Input.is_action_pressed("ui_right"):
		animations.play('punch')
	if Input.is_action_pressed("ui_up"):
		animations.play('shock')
	
	
	if feet.is_colliding():
		if not animations.is_playing():
			animations.play('idle')
		if Input.is_action_pressed('up'):
			animations.play('jump')
			sfx.play('jump')
			apply_impulse(get_pos(),Vector2(0,-jump_height))
		if Input.is_action_pressed('down'):
			animations.play('crouch')
		if Input.is_action_pressed('left'):
			set_axis_velocity(Vector2(-move_speed,0))
			sprite.set('flip_h',true)
		if Input.is_action_pressed('right'):
			set_axis_velocity(Vector2(move_speed,0))
			sprite.set('flip_h',false)
		if Input.is_action_pressed('down'):
			animations.play('crouch')

