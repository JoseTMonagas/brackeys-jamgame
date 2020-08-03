extends Control


func _on_Start_pressed():
	Global.change_scene("res://Animations/Start.tscn")
	

func _on_Settings_pressed():
	Global.change_scene(Global.SETTINGS)


func _on_Credits_pressed():
	pass # Replace with function body.


func _on_Exit_pressed():
	Global.quit()

func _on_Start_mouse_entered():
	pass # Replace with function body.


func _on_Settings_mouse_entered():
	pass # Replace with function body.


func _on_Credits_mouse_entered():
	pass # Replace with function body.


func _on_Exit_mouse_entered():
	pass # Replace with function body.
