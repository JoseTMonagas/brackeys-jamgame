extends Control


onready var hover = $Hover
onready var pressed = $Pressed


func _play_pressed():
	pressed.play()


func _play_hover():
	hover.play()


func _on_Start_pressed():
	_play_pressed()
	Global.change_scene("res://Animations/Start.tscn")
	

func _on_Settings_pressed():
	_play_pressed()
	Global.change_scene(Global.SETTINGS)


func _on_Credits_pressed():
	_play_pressed()
	Global.change_scene("res://UI/Credits.tscn")


func _on_Exit_pressed():
	_play_pressed()
	Global.quit()


func _on_Start_mouse_entered():
	_play_hover()


func _on_Settings_mouse_entered():
	_play_hover()


func _on_Credits_mouse_entered():
	_play_hover()


func _on_Exit_mouse_entered():
	_play_hover()
