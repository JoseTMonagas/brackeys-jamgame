extends Node2D

signal cutscene_ended

onready var animation_player = $AnimationPlayer


func _ready():
	if animation_player.has_animation("default"):
		animation_player.play("default")


func _goto(path):
	Global.change_scene(path)


func play_animation(animation_name):
	animation_player.play(animation_name)
	


func play_animation_backwards(animation_name):
	animation_player.play_backwards(animation_name)


func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("cutscene_ended")
