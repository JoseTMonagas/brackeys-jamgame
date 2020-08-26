extends Node2D

signal cutscene_ended

onready var animation_player = $AnimationPlayer
#onready var AnimationMonsterSummoning = get_node("res://Animations/Monster_Summoning.tscn")
#onready var AnimationFarm = get_node("res://Animations/FarmDestruction.tscn")
#onready var AnimationTreeDestruction = get_node("res://Animations/TreeDestruction.tscn")
#onready var AnimationRock = get_node("res://Animations/MovingRockAnimation.tscn")
#onready var AnimationBars = get_node("res://Animations/BarsSummonning.tscn")


var newTrySummon:bool= true
var newTryFarm:bool= true
var newTryTree:bool= true
var newTryRock:bool= true
var newTryBars:bool= true


func _ready():
	if animation_player.has_animation("default"):
		animation_player.play("default")
	elif animation_player.has_animation("play_movie_forward") and newTrySummon:
		animation_player.play("play_movie_forward")
		newTrySummon = false
	elif animation_player.has_animation("PlayFarm") and newTryFarm:
		animation_player.play("PlayFarm")
		newTryFarm = false
	elif animation_player.has_animation("PlayTree") and newTryTree:
		animation_player.play("PlayTree")
		newTryTree = false
	elif animation_player.has_animation("PlayRock") and newTryRock:
		animation_player.play("PlayRock")
		newTryRock = false
	elif animation_player.has_animation("PlayBars") and newTryBars:
		animation_player.play_backwards("PlayBars")
		newTryBars = false


func _goto(path):
	Global.change_scene(path)


func play_animation(animation_name):
	animation_player.play(animation_name)


func play_animation_backwards(animation_name):
	animation_player.play_backwards(animation_name)


func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("cutscene_ended")
