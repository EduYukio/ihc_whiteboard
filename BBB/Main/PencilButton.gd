extends Button

const CanvasScene = preload("res://BBB//Canvas//Canvas.tscn")
onready var main_node = get_node("/root/Main")
onready var interface_node = main_node.get_node("BBB_Interface")

func _on_PencilButton_pressed():
	if not main_node.has_node("SlideCanvas") and not main_node.has_node("WhiteCanvas"):
		create_slide_canvas()

func create_slide_canvas():
	var CanvasInstance = CanvasScene.instance()
	CanvasInstance.background_color = Color(0,0,0,0)
	CanvasInstance.set_name("SlideCanvas")
	main_node.add_child_below_node(interface_node, CanvasInstance)
	CanvasInstance.rect_position = Vector2(624,192)