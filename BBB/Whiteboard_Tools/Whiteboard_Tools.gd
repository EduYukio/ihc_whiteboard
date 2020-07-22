extends Control

enum {NONE, PENCIL_TOOLS, THICKNESS, COLOR, UNDO, REDO, TRASH, SHARE, TEXT, LINE, CIRCLE, TRIANGLE, SQUARE, ERASER, PENCIL}

signal tool_changed(new_tool)

func _on_wb_button_pressed(button : Button, type : int):
	if type != PENCIL_TOOLS:
		emit_signal("tool_changed", type)

	match(type):
		PENCIL_TOOLS:
			$pencil_tools.visible = not $pencil_tools.visible

		TEXT, LINE, CIRCLE, TRIANGLE, SQUARE, ERASER, PENCIL:
			show_button_highlight(button)


func show_button_highlight(button):
	$whiteboard_tools/PencilTools/tool.frame = button.button_type - 8
	$pencil_tools/Selected.show()
	$pencil_tools/Selected.set_modulate(Color(1,1,1,1))
	$pencil_tools/Selected.position = button.rect_position
	$pencil_tools/Selected.polygon[1].x = button.rect_size.x
	$pencil_tools/Selected.polygon[2].x = button.rect_size.x
