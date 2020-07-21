extends Button

func _on_PlusButton_pressed():
	if not $PlusPopup.visible:
		$PlusPopup.show()

	else:
		$PlusPopup.hide()
