extends ProgressBar

var time = 0

func _ready():
	set_process(true)

func _process(delta):
	time+=delta
	if get_val()<100:
		set_val(time*10)
	else:
		time=0
		set_val(time)
