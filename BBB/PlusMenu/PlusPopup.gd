extends Sprite

const open_sprite = preload("res://Assets//popup_open_wb.png")
const close_sprite = preload("res://Assets//popup_close_wb.png")

var new_canvas : bool = true
signal temp_whiteboard(new)

func _on_NewWhiteboardButton_pressed():
	self.hide()

	if not new_canvas:
		self.texture = open_sprite

	else:
		self.texture = close_sprite

	emit_signal("temp_whiteboard", new_canvas)
	new_canvas = not new_canvas
