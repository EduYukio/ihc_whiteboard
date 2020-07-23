extends TextureRect

var WIDTH : int = 1343
var HEIGHT : int  = 795
var RADIUS : int = 10
var BETWEEN_DIST : float = RADIUS/2.0
var UNDO_LIMIT : int = 20

var image : Image
var undo_array : Array = []
var redo_array : Array = []

enum {NONE, PENCIL_TOOLS, THICKNESS, COLOR, UNDO, REDO, TRASH, SHARE, TEXT, LINE, CIRCLE, TRIANGLE, SQUARE, ERASER, PENCIL}
var mode : int = NONE setget change_mode

var pencil_color : Color = Color.black
var background_color : Color = Color(0, 0, 0, 0)

var mouse_pressed : bool = false

var last_pos : Vector2 = Vector2(0,0)

var drawable : bool = true

func change_mode(new_mode : int):
	match(new_mode):
		NONE, TEXT, LINE, CIRCLE, TRIANGLE, SQUARE, ERASER, PENCIL:
			mode = new_mode

		UNDO:
			if undo_array.empty():
				clear_image()

			else:
				var last_action : Image = undo_array.pop_back()
				redo_array.append(last_action)

				if undo_array.empty():
					clear_image()

				else:
					image.call_deferred("free")
					image = undo_array.back().duplicate()
					self.texture.image = image

		REDO:
			if not redo_array.empty():
				var last_action : Image = redo_array.pop_back()
				undo_array.append(last_action)
				image.call_deferred("free")
				image = undo_array.back().duplicate()
				self.texture.image = image

		TRASH:
			undo_array.append(image.duplicate())
			clear_image()

func clear_image() -> void:
	image.lock()
	image.fill(background_color)
	image.unlock()
	self.texture.image = image

func _ready():
	self.texture = ImageTexture.new()

	WIDTH = int(self.rect_size.x)
	HEIGHT = int(self.rect_size.y)

	image = Image.new()
	image.create(WIDTH, HEIGHT, false, Image.FORMAT_RGBA8)
	image.fill(background_color)

	self.texture.image = image

func _process(_delta):
	if mouse_pressed and drawable:
		if mode == PENCIL:
			paint(pencil_color)

		elif mode == ERASER:
			paint(background_color)

		last_pos = get_local_mouse_position()

func _input(event):
	if event is InputEventMouseButton:
		var mouse_event : InputEventMouseButton = event

		if mouse_event.button_index == BUTTON_LEFT:
			var mouse_pos : Vector2 = get_local_mouse_position()

			if mouse_event.pressed and \
			 mouse_pos.x >= 0 and mouse_pos.y >= 0 and \
			 mouse_pos.x <= rect_size.x and mouse_pos.y <= rect_size.y:
				last_pos = get_local_mouse_position()
				mouse_pressed = true

				if not redo_array.empty():
					while not redo_array.empty():
						redo_array.pop_back().call_deferred("free")

			elif mouse_pressed:
				mouse_pressed = false
				undo_array.append(image.duplicate())
				if len(undo_array) > UNDO_LIMIT:
					undo_array.pop_front().call_deferred("free")

func paint(color):
	var cur_pos : Vector2 = get_local_mouse_position()

	var line : Vector2 = (cur_pos - last_pos)
	var num_circles : int = int(line.length()/BETWEEN_DIST)+1

	image.lock()

	line = line.normalized()

	for x in num_circles:
		var pos : Vector2 = line*BETWEEN_DIST*x+last_pos

		for i in range(-RADIUS+int(pos.x), RADIUS+int(pos.x)):
			if i >= 0 and i < WIDTH:
				for j in range(-RADIUS+int(pos.y), RADIUS+int(pos.y)):
					if j >= 0 and j < HEIGHT:
						var dist = Vector2(i,j) - pos
						if dist.length() <= RADIUS:
							image.set_pixel(i, j, color)

	image.unlock()
	self.texture.image = image


func _on_Whiteboard_Panel_is_drawable(state):
	drawable = state

