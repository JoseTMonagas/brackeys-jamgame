extends Control


func _input(event):
	if event is InputEventKey || event is InputEventMouseButton:
		Global.change_scene("res://Map/Map.tscn")
