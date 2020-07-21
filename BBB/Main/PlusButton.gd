extends Button

const PlusPopupScene = preload("res://BBB//PlusMenu//PlusPopup.tscn")
var PlusPopupInstance

func _ready():
	pass # Replace with function body.

func _on_PlusButton_pressed():
	if not has_node("PlusPopup"): 
		PlusPopupInstance = PlusPopupScene.instance()
		self.add_child(PlusPopupInstance)
		PlusPopupInstance.position = PlusPopupInstance.position + Vector2(0,-82)
	else:
		PlusPopupInstance.queue_free()
