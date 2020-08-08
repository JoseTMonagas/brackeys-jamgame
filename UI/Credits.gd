extends Control


func _on_Button_pressed():
	$Pressed.play()
	Global.change_scene(Global.MAIN_MENU)


func _on_Button_mouse_entered():
	$Hover.play()
