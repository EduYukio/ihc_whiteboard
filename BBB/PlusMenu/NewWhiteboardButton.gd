extends Button

const CANVAS_SCENE = preload("res://BBB//Canvas//Canvas.tscn")
onready var main_node = get_node("/root/Main")
onready var interface_node = main_node.get_node("BBB_Interface")

func _on_NewWhiteboardButton_pressed():
	# create whiteboard
	if not main_node.has_node("WhiteCanvas"):
		# guarda slide canvas, se tiver
		if main_node.has_node("SlideCanvas"):
			var slide_canvas = get_node("/root/Main/SlideCanvas")
			main_node.store_canvas(slide_canvas)

		create_white_canvas()

	# close whiteboard
	else:
		# respawna o slide canvas guardado, se tiver
		if main_node.has_stored_canvas():
			var slide_canvas = main_node.pop_canvas()
			main_node.add_child_below_node(interface_node, slide_canvas)

		get_node("/root/Main/WhiteCanvas").queue_free()

	get_parent().queue_free()

func create_white_canvas():
	var canvas_instance = CANVAS_SCENE.instance()
	canvas_instance.background_color = Color.white
	canvas_instance.set_name("WhiteCanvas")
	main_node.add_child_below_node(interface_node, canvas_instance)
	canvas_instance.rect_position = Vector2(624,192)
