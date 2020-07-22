extends Button

enum buttons {NONE, PENCIL_TOOLS, THICKNESS, COLOR, UNDO, REDO, TRASH, SHARE, TEXT, LINE, CIRCLE, TRIANGLE, SQUARE, ERASER, PENCIL}
export(buttons) var button_type : int = 0

signal wb_button_pressed(button, type)

func _on_Whiteboard_Tools_pressed():
	emit_signal("wb_button_pressed", self, button_type)
	
func _on_Pencil_Tools_pressed():
	# achei que seria necessario dividir, mas nem foi, refatorar?
	emit_signal("wb_button_pressed", self, button_type)
