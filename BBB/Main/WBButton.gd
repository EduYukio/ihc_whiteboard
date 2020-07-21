extends Button

enum buttons {NONE, PENCIL, CIRCLE, SQUARE, UNDO, REDO, TRASH, SHARE}
export(buttons) var button_type : int = 0

signal wb_button_pressed(button, type)

func _on_PencilButton_pressed():
	emit_signal("wb_button_pressed", self, button_type)
