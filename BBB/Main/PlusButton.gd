extends Button

signal plus_button_clicked()

func _on_PlusButton_pressed():
	emit_signal("plus_button_clicked")
	$PlusPopup.visible = not $PlusPopup.visible

func _on_Canvas_paint():
	$PlusPopup.visible = false

func _on_Whiteboard_Panel_menu_was_clicked():
	$PlusPopup.visible = false
