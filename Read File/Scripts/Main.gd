
extends Control

var label

func _ready():
	label = get_node("RichTextLabel")
	var f =File.new()
	f.open('res://gdscript.md',1)
	label.add_text(f.get_as_text())
	f.close()
	
	set_process(true)
	OS.set_low_processor_usage_mode(true)
	

func _process(delta):
	label.set('rect/size',get_viewport_rect().size)
