#-----------------------------
# Godot Code Snippets (2D)    |
# By the Tutorial Doctor      | 
# Fri Sep 18 13:14:07 EDT 2015|
#-----------------------------


# MAKE AN OBJECT FOLLOW THE MOUSE
func followMouse(x):
	var mouse_position = get_viewport().get_mouse_pos()
	x.set_pos(mouse_position)

#Example Usage: followMouse(cursor)



# MAKE AN OBJECT LOOK AT THE MOUSE
func lookAtMouse(x):
	var mouse_position = get_viewport().get_mouse_pos()
	x.look_at(mouse_position)

#Example Usage: lookAtMouse(arrow)



# MAKE AN OBJECT FLIPABLE
func makeFlipable(x,boolean=true):
	# If the parameter is false, exit the function
	if boolean == false:
		return
	# Otherwise if the parameter is true...
	elif boolean == true:
		# And if left arrow is pressed..
		if Input.is_action_pressed("ui_left"):
			# Set the Flip H property to true.
			x.set('flip_h',true)
		# Otherwise, if the right arrow is pressed...
		elif Input.is_action_pressed("ui_right"):
			# Set the Flip H property to false
			x.set('flip_h',false)

#Example Usage: makeFlipable(player)



# MOVE AN OBJECT (constant speed) LEFT OR RIGHT ON KEY PRESS
func move(direction,obj):
    var move_speed = 5
	if direction == 'right':
		obj.set_pos(Vector2(obj.get_pos()[0] + move_speed,obj.get_pos()[1]))
	if direction == 'left':
		obj.set_pos(Vector2(obj.get_pos()[0] - move_speed,obj.get_pos()[1]))

# Example Usage:
#if Input.is_action_pressed("ui_right"):
    #move('right')
#elif Input.is_action_pressed("ui_left"):
    #move('left')



# CHANGE TO LEVEL ON BUTTON PRESS:
func changeLevel(btn,lvl):
    if btn.is_pressed():
        get_tree().change_scene("res://"+lvl+".scn")

# Example Usage: changeLevel(menu_button,'Menu')
# This checks for a scene in the resources folder
# Must run under the _process function



# MAKE AN OBJECT JUMP ON KEY PRESS



# LOOP AN ANIMATED SPRITE (TO BE TESTED)
var frames = self.get_sprite_frames()

func loopAnimation(x,d):
	# Increment the elapsed time (seconds)
	dt = dt + d
	# I don't like the .1 for speed, so I could change this to dt = dt + delta*10, and set speed to 1.
	# I will leave it for demonstration purposes
	
	# If the elapsed time is greater than one frame...
	if(dt > speed):
		# And if the current frame is equal to the last frame minus 1 (second to last frame)...
		if(x.get_frame() == frames.get_frame_count() -1):
			# Set the frame of this sprite to the first frame
			x.set_frame(0)
		# Otherwise...
		else:
    	# Set the current frame to the next frame
        	x.set_frame(x.get_frame() + 1)
		
		# If you want the sprite to translate (as if walking forward), if it is a walking animation of course:
		#x.set_pos(Vector2(x.get_pos().x + 1,x.get_pos().y))
		
		# Now, reset the elapsed time
		dt = 0
#Example Usage: loopAnimation(bird,delta)
# Use under _process() function, and pass in delta as second argument