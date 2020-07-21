extends Sprite

onready var main_node = get_node("/root/Main")
const openSprite = preload("res://Assets//popupOpenWhiteBoard.png")
const closeSprite = preload("res://Assets//popupCloseWhiteBoard.png")

func _ready():
	if not main_node.has_node("WhiteCanvas"):
		self.texture = openSprite
	else:
		self.texture = closeSprite
		

