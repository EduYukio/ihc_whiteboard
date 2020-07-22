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

	remove_child(cur_canvas)
	self.add_child_below_node($BBB_Interface, canvas_instance)
	cur_canvas = canvas_instance

func pop_canvas():
	cur_canvas.call_deferred("free")
	self.add_child_below_node($BBB_Interface, stored_canvas)
	cur_canvas = stored_canvas
	stored_canvas = null

func _on_Whiteboard_tool_changed(new_tool):
	cur_canvas.mode = new_tool

func _on_Whiteboard_pencil_button_pressed():
	$PencilToolsSprite.visible = !$PencilToolsSprite.visible
