extends Control

enum {NONE, PENCIL_TOOLS, THICKNESS, COLOR, UNDO, REDO, TRASH, SHARE, TEXT, LINE, CIRCLE, TRIANGLE, SQUARE, ERASER, PENCIL}

signal tool_changed(new_tool)
signal color_changed(new_color)
signal thickness_changed(new_thickness)
signal is_drawable(state)
signal menu_was_clicked()

onready var pencil_tools = $pencil_tools
onready var thickness_slider = $whiteboard_tools/Thickness/Slider_Pos
onready var color_picker = $whiteboard_tools/Color/Picker_Position

onready var menus = [pencil_tools, thickness_slider, color_picker]

var node_array = []

func _ready():
	connect_color_picker_nodes()

func connect_color_picker_nodes():
	var color_picker = get_node("whiteboard_tools/Color/Picker_Position/ColorPicker")
	get_all_nodes(color_picker)
	for node in node_array:
		if node is Control:
			node.mouse_filter = MOUSE_FILTER_PASS
			if not node.is_connected("mouse_entered", self, "_on_NotDrawableArea_mouse_entered"):
				node.connect("mouse_entered", self, "_on_NotDrawableArea_mouse_entered")
				
			if not node.is_connected("mouse_exited", self, "_on_NotDrawableArea_mouse_exited"):
				node.connect("mouse_exited", self, "_on_NotDrawableArea_mouse_exited")
				
func get_all_nodes(node):
	node_array.append(node)
	for N in node.get_children():
		if N.get_child_count() > 0:
			if not node_array.has(N):
				node_array.append(N)
			get_all_nodes(N)
		else:
			if not node_array.has(N):
				node_array.append(N)
			
func _on_wb_button_pressed(button : Button, type : int):
	if type != PENCIL_TOOLS:
		emit_signal("tool_changed", type)

	match(type):
		PENCIL_TOOLS:
			open_or_close_only_this_menu(pencil_tools)

		THICKNESS:
			open_or_close_only_this_menu(thickness_slider)

		COLOR:
			open_or_close_only_this_menu(color_picker)

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

func close_all_menus():
	for menu in menus:
		menu.visible = false
		
func open_or_close_only_this_menu(menu):
	emit_signal("menu_was_clicked")
	if menu.visible:
		menu.visible = false
		return
		
	close_all_menus()
	menu.visible = true
		
func _on_Canvas_paint():
	close_all_menus()

func _on_PlusButton_plus_button_clicked():
	close_all_menus()
