extends Sprite

const open_sprite = preload("res://Assets//popup_open_wb.png")
const close_sprite = preload("res://Assets//popup_close_wb.png")

var new_canvas : bool = true
signal temp_whiteboard(new)
signal is_drawable(state)

func _on_NewWhiteboardButton_pressed():
	self.hide()

	if not new_canvas:
		self.texture = open_sprite

	else:
		self.texture = close_sprite

	emit_signal("temp_whiteboard", new_canvas)
	new_canvas = not new_canvas
	emit_signal("is_drawable", true)
	
func _on_NotDrawableArea_mouse_entered():
	emit_signal("is_drawable", false)
	
func _on_NotDrawableArea_mouse_exited():
	emit_signal("is_drawable", true)
