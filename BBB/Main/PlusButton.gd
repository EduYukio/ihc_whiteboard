extends Button

const PLUS_POPUP_SCENE = preload("res://BBB//PlusMenu//PlusPopup.tscn")
var plus_popup_instance

func _on_PlusButton_pressed():
	if not has_node("PlusPopup"):
		plus_popup_instance = PLUS_POPUP_SCENE.instance()
		self.add_child(plus_popup_instance)
		plus_popup_instance.position += Vector2(-2,-135)
	else:
		plus_popup_instance.queue_free()
