extends Control

export var path = "res://Map/Map.tscn"

func _input(event):
	if event is InputEventKey || event is InputEventMouseButton:
		Global.change_scene(path)
