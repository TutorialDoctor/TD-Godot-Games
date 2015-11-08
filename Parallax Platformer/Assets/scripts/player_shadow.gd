
extends Sprite

var player


func _ready():
	set_process(true)
	player = get_node('/root/Node2D/Game Objects/Player 1/Sprite')
	set_pos(Vector2(player.get_pos()[0],player.get_pos()[1]))
func _process(delta):
	set_pos(Vector2(player.get_pos()[0],player.get_pos()[1]+9))


