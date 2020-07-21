extends HBoxContainer

enum {NONE, PENCIL, CIRCLE, SQUARE, UNDO, REDO, TRASH, SHARE}

signal tool_changed(new_tool)

func _on_wb_button_pressed(button : Button, type : int):

	emit_signal("tool_changed", type)

	match(type):
		PENCIL, CIRCLE, SQUARE:
			$Selected.show()
			$Selected.position = button.rect_position
			$Selected.polygon[1].x = button.rect_size.x
			$Selected.polygon[2].x = button.rect_size.x
