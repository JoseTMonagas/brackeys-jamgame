extends Node2D


func _ready():
	$Monster_Summoning.visible = true
	$Monster_Summoning.play_animation("play_movie_forward")


func _play_cutscene(node, animation_name):
	node.visible = true
	node.play_animation(animation_name)


func _on_Monster_Summoning_cutscene_ended():
	$Monster_Summoning.visible = false
	$BarsSummonning.visible = true
	$BarsSummonning.play_animation_backwards("PlayBars")


func _on_BarsSummonning_cutscene_ended():
	$BarsSummonning.visible = false
	_play_cutscene($MovingRockAnimation, "PlayRock")

func _on_MovingRockAnimation_cutscene_ended():
	$MovingRockAnimation.visible = false
	_play_cutscene($TreeDestruction, "PlayTree")

func _on_TreeDestruction_cutscene_ended():
	$TreeDestruction.visible = false
	_play_cutscene($FarmDestruction, "PlayFarm")

func _on_FarmDestruction_cutscene_ended():
	Global.change_scene("res://UI/Instructions.tscn")
