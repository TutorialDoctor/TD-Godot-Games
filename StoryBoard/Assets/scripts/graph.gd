
extends GraphEdit

# need a button to display, but at least I know how it works now. I need to organize this stuff now.

func _ready():
	set_right_disconnects(true)
	connect_node('A',0,'B',1)
	var node =  GraphNode.new()
	node.set_title('Dialog FLow')
	add_child(node)