extends HBoxContainer

enum {NONE, PENCIL_TOOLS, THICKNESS, COLOR, UNDO, REDO, TRASH, SHARE, TEXT, LINE, CIRCLE, TRIANGLE, SQUARE, ERASER, PENCIL}

signal tool_changed(new_tool)
signal pencil_button_pressed()

func _on_wb_button_pressed(button : Button, type : int):
	emit_signal("tool_changed", type)

	match(type):
		PENCIL_TOOLS:
			emit_signal("pencil_button_pressed")
				
		TEXT, LINE, CIRCLE, TRIANGLE, SQUARE, ERASER, PENCIL:
			show_button_highlight(button)
			emit_signal("pencil_button_pressed")
	

func show_button_highlight(button):
	$Selected.show()
	$Selected.set_modulate(Color(1,1,1,1))
	$Selected.position = button.rect_position
	$Selected.polygon[1].x = button.rect_size.x
	$Selected.polygon[2].x = button.rect_size.x
