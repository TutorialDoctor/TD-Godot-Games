extends RigidBody2D

var sprite
var feet
var sfx
var animations
var timer
export var move_speed = 0
export var jump_height = 0
export var next_level =''
var shake_cam
var can_stomp = true
	
func _ready():
	set_process(true)
	animations = get_node("Sprite/AnimationPlayer")
	sprite = get_node("Sprite")
	sfx = get_parent().get_node("SFX")
	feet = get_node("Feet")
	feet.add_exception(self)
	shake_cam = get_parent().get_node("Man/Camera2D")
	
	# Testing instance stuff
	#print(get_instance_ID())
	#var inst = instance_from_id(get_instance_ID())
	#get_parent().add_child(inst)
	#print(inst.get_instance_ID())
	#inst.queue_free()

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
			#sfx.play('jump') (this sound is now played in the animation player)
			# There is an issue with overlpaping sounds cutting one another off.
			# The issue still occurs even though I have changed the voices, and moved the sound to the animation player
			# I am sure a bit of code can fix this though. 
			apply_impulse(get_pos(),Vector2(0,-jump_height))
		if Input.is_action_pressed('down'):
			animations.play('crouch')
			shake_cam.shake(.2,15,100)
		if Input.is_action_pressed('left'):
			set_axis_velocity(Vector2(-move_speed,0))
			sprite.set('flip_h',true)
		if Input.is_action_pressed('right'):
			set_axis_velocity(Vector2(move_speed,0))
			sprite.set('flip_h',false)




# This function was generated using the node connections option.
# A collisioin shape had to be added to Area2d for it to work.
func _on_Area2D_body_enter( body ):
	get_tree().change_scene(next_level)
