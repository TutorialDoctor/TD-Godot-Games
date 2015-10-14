extends AnimatedSprite

# Elapsed time(dt/delta t) starts at 0
var dt = 0
var frames = null
var current_frame = null


# Speed: A tenth of a second is equal to one frame (60fps)
# The lower the faster
export var speed = .1 # Exported this property to the Inspector, so you can change it form there

func _ready():
	frames = self.get_sprite_frames()
	set_process(true)


func _process(delta):
	# Increment the elapsed time (seconds)
	dt = dt + delta
	# I don't like the .1 for speed, so I could change this to dt = dt + delta*10, and set speed to 1.
	# I will leave it for demonstration purposes
	
	# If the elapsed time is greater than one frame...
	if(dt > speed):
		# And if the current frame is equal to the last frame minus 1 (second to last frame)...
		if(get_frame() == frames.get_frame_count() -1):
			# Set the frame of this sprite to the first frame
			set_frame(0)
		# Otherwise...
		else:
			# Set the current frame to the next frame
			self.set_frame(get_frame() + 1)
		
		# If you want the sprite to translate (as if walking forward), if it is a walking animation of course:
		#set_pos(Vector2(get_pos().x + 1,get_pos().y))
		
		# Now, reset the elapsed time
		dt = 0
		# The process will repeat, giving an animated sprite. This could be achieved easier using an animation player, but code is fun! Right? :)
	
#----------------------------------------
	

		
