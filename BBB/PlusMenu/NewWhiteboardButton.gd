extends Button

const CanvasScene = preload("res://BBB//Canvas//Canvas.tscn")
onready var main_node = get_node("/root/Main")
var CanvasInstance

func _on_NewWhiteboardButton_pressed():
	if not main_node.has_node("Canvas"): 
		CanvasInstance = CanvasScene.instance()
		var popup_node = get_parent()
		main_node.add_child_below_node(popup_node, CanvasInstance)
		CanvasInstance.rect_position = CanvasInstance.rect_position + Vector2(624,192)
	else:
		get_node("/root/Main/Canvas").queue_free()
		
	get_parent().queue_free()
