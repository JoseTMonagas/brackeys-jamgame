extends Spatial

onready var monument1 = $Monument1
onready var cutscenes = $Cutscenes
onready var creature = $Creature


func _play_cutscene(node_name, animation_name):
	creature.force_rest = true
	var cutscene = cutscenes.get_node(node_name)
	cutscene.visible = true
	cutscene.play_animation(animation_name)
	yield(cutscene, "cutscene_ended")
	cutscene.visible = false


func _on_Monument1_activated():
	_play_cutscene("PeredoSummoning", "play_movie_backwards")
	
