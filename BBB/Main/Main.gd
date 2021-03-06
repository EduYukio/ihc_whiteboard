extends Node2D

const CANVAS_SCENE = preload("res://BBB//Canvas//Canvas.tscn")

onready var cur_canvas : TextureRect = $Canvas
var stored_canvas

func _on_temp_whiteboard(new : bool):
	if new:
		temp_canvas()

	else:
		pop_canvas()

func temp_canvas():
	stored_canvas = cur_canvas
	var canvas_instance : TextureRect = CANVAS_SCENE.instance()
	canvas_instance.background_color = Color.white
	canvas_instance.rect_position = cur_canvas.rect_position
	canvas_instance.rect_size = cur_canvas.rect_size
	canvas_instance.mode = cur_canvas.mode
	canvas_instance.pencil_color = cur_canvas.pencil_color
	canvas_instance.RADIUS = cur_canvas.RADIUS

	remove_child(cur_canvas)
	self.add_child_below_node($BBB_Interface, canvas_instance)
	cur_canvas = canvas_instance
	var _error = $PlusButton/PlusPopup.connect("is_drawable", canvas_instance, "_on_Whiteboard_Panel_is_drawable")
	_error = $Whiteboard_Panel.connect("is_drawable", canvas_instance, "_on_Whiteboard_Panel_is_drawable")
	_error = canvas_instance.connect("paint", $Whiteboard_Panel, "_on_Canvas_paint")
	_error = canvas_instance.connect("paint", $PlusButton, "_on_Canvas_paint")
	

func pop_canvas():
	stored_canvas.mode = cur_canvas.mode
	stored_canvas.pencil_color = cur_canvas.pencil_color
	stored_canvas.RADIUS = cur_canvas.RADIUS
	cur_canvas.call_deferred("free")
	self.add_child_below_node($BBB_Interface, stored_canvas)
	cur_canvas = stored_canvas
	stored_canvas = null

func _on_Whiteboard_tool_changed(new_tool):
	cur_canvas.mode = new_tool

func _on_color_changed(new_color):
	cur_canvas.pencil_color = new_color

func _on_thickness_changed(new_thickness):
	cur_canvas.RADIUS = new_thickness
