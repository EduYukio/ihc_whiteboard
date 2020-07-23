extends Control

enum {NONE, PENCIL_TOOLS, THICKNESS, COLOR, UNDO, REDO, TRASH, SHARE, TEXT, LINE, CIRCLE, TRIANGLE, SQUARE, ERASER, PENCIL}

signal tool_changed(new_tool)
signal color_changed(new_color)
signal thickness_changed(new_thickness)
signal is_drawable(state)

func _on_wb_button_pressed(button : Button, type : int):
	if type != PENCIL_TOOLS:
		emit_signal("tool_changed", type)

	match(type):
		PENCIL_TOOLS:
			$pencil_tools.visible = not $pencil_tools.visible

		THICKNESS:
			$whiteboard_tools/Thickness/Slider_Pos.visible = not $whiteboard_tools/Thickness/Slider_Pos.visible

		COLOR:
			$whiteboard_tools/Color/Picker_Position.visible = not $whiteboard_tools/Color/Picker_Position.visible

		TEXT, LINE, CIRCLE, TRIANGLE, SQUARE, ERASER, PENCIL:
			emit_signal("is_drawable", true)
			$pencil_tools.visible = false
			show_button_highlight(button)

func show_button_highlight(button):
	$whiteboard_tools/PencilTools/tool.frame = button.button_type - 8
	$pencil_tools/Selected.show()
	$pencil_tools/Selected.set_modulate(Color(1,1,1,1))
	$pencil_tools/Selected.position = button.rect_position
	$pencil_tools/Selected.polygon[1].x = button.rect_size.x
	$pencil_tools/Selected.polygon[2].x = button.rect_size.x

func _on_color_changed(color):
	$whiteboard_tools/Color/color_picked.color = color
	emit_signal("color_changed", color)

func _on_thickness_changed(value):
	update()
	emit_signal("thickness_changed", value)

func _on_NotDrawableArea_mouse_entered():
	emit_signal("is_drawable", false)

func _on_NotDrawableArea_mouse_exited():
	emit_signal("is_drawable", true)

func _draw():
	var pos : Vector2 = $whiteboard_tools/Thickness.rect_position + Vector2(21,21)
	var radius : float = $whiteboard_tools/Thickness/Slider_Pos/Slider.value
	draw_circle(pos, radius, Color.black)
