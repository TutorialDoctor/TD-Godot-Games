
extends Node2D

# I didn't add labels to the sprites at first, so I had to do it programmatically. Sorry about that.
# However, this is a good lesson in nested loops
# And as a matter of fact, it is better, because this will work for all new sprites that are added.

func _ready():
	for child in get_children():
		child.add_child(Label.new())
		if child.is_type('Sprite'):
			for child_2 in child.get_children():
				if child_2.get_type()=='Label':
					child_2.set_text(child.get_name())
					child_2.set_pos(get_pos()+Vector2(0,-150))
					child_2.set('custom_colors/font_color',Color(0,1,0))


