
extends Tree
# Gotta figure out how GDNative classes work. I think I will need this node
var root = null

func _ready():
	#create_item(get_root()).set_text(0,'Item 1')
	for x in range(0,5):
		create_item(TreeItem.new()).set_text(0,'Level '+str(x))
	
	root = get_root()
	root.set_text(0,'Outline')
	
	print(root)
	print(get_columns())