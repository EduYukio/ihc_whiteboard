extends Control

const WIDTH : int = 640
const HEIGHT : int  = 480
const RADIUS : int = 30

onready var rect = $TextureRect
var image : Image

var is_painting : bool = false

func _ready():
	image = Image.new()
	image.create(WIDTH, HEIGHT, true, Image.FORMAT_RGBA8)
	image.fill(Color.white)

	rect.texture.image = image

func _process(delta):
	if is_painting:
		paint(Color.black)

func _input(event):
	if event is InputEventMouseButton:
		var mouse_event : InputEventMouseButton = event
		if mouse_event.button_index == BUTTON_LEFT:
			if mouse_event.pressed:
				is_painting = true
			else:
				is_painting = false

func paint(color):
	var pos := get_global_mouse_position()

	image.lock()

	for i in range(-RADIUS+int(pos.x), RADIUS+int(pos.x)):
		if i >= 0 and i < WIDTH:
			for j in range(-RADIUS+int(pos.y), RADIUS+int(pos.y)):
				if j >= 0 and j < HEIGHT:
					var dist = Vector2(i,j) - pos
					if dist.length() <= RADIUS:
						image.set_pixel(i, j, color)

	image.unlock()
	rect.texture.image = image
