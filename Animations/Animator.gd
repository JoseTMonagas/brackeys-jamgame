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
	animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	if animation_player.has_animation("default"):
		animation_player.play("default")


func _goto(path):
	Global.change_scene(path)


func play_animation(animation_name):
	animation_player.play(animation_name)


func play_animation_backwards(animation_name):
	animation_player.play_backwards(animation_name)


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("cutscene_ended")
