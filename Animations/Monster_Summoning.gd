extends Node2D

onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("play_movie_backwards")

func _goto(path):
	Global.change_scene(path)
