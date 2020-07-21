extends Node2D

var stored_canvas

func store_canvas(canvas):
	stored_canvas = canvas
	remove_child(canvas)

func pop_canvas():
	var aux = stored_canvas
	stored_canvas = null
	return aux

func has_stored_canvas():
	if stored_canvas == null:
		return false
	else:
		return true
