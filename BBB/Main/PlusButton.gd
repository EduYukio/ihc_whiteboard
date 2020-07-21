extends Button

const PlusPopupScene = preload("res://BBB//PlusMenu//PlusPopup.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlusButton_pressed():
	var PlusPopupInstance = PlusPopupScene.instance()
	self.add_child(PlusPopupInstance)
	PlusPopupInstance.position = PlusPopupInstance.position + Vector2(0,-82)
