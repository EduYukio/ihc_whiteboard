extends Sprite

onready var main_node = get_node("/root/Main")
const open_sprite = preload("res://Assets//popupOpenWhiteBoard.png")
const close_sprite = preload("res://Assets//popupCloseWhiteBoard.png")

func _ready():
	if not main_node.has_node("WhiteCanvas"):
		self.texture = open_sprite
	else:
		self.texture = close_sprite
		

