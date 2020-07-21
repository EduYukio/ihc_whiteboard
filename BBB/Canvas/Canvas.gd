extends TextureRect

var WIDTH : int = 1343
var HEIGHT : int  = 795
var RADIUS : int = 10
var BETWEEN_DIST : float = RADIUS/2

var image : Image

enum {NONE, PAINTING, ERASING}
var mode : int = NONE
var background_color

var last_pos : Vector2 = Vector2(0,0)

func _ready():
	self.texture = ImageTexture.new()

	self.rect_size.x = WIDTH
	self.rect_size.y = HEIGHT

	image = Image.new()
	image.create(WIDTH, HEIGHT, false, Image.FORMAT_RGBA8)
	image.fill(background_color)

	self.texture.image = image

func _process(delta):
	if mode == PAINTING:
		paint(Color.black)

	elif mode == ERASING:
		paint(background_color)

	last_pos = get_local_mouse_position()

func _input(event):
	if event is InputEventMouseButton:
		var mouse_event : InputEventMouseButton = event
		if mouse_event.button_index == BUTTON_LEFT:
			if mouse_event.pressed:
				mode = PAINTING

			else:
				mode = NONE

		elif mouse_event.button_index == BUTTON_RIGHT:
			if mouse_event.pressed:
				mode = ERASING

			else:
				mode = NONE

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
