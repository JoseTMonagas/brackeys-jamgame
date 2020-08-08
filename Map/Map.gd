extends Spatial

onready var monument1 = $Monument1
onready var cutscenes = $Cutscenes
onready var creature = $Creature

onready var FarmLocked = get_node("Farm/Locked")
onready var FarmUnlocked = get_node("Farm/Unlocked")

onready var TreeLocked = get_node("BigTree/Locked")
onready var TreeUnlocked = get_node("BigTree/Unlocked")

onready var RockLocked = get_node("BlockingRock")

onready var BarsLocked = get_node("BlackBars")


func _play_cutscene(node_name, animation_name):
	creature.force_rest = true
	var cutscene = cutscenes.get_node(node_name)
	cutscene.visible = true
	cutscene.play_animation(animation_name)
	yield(cutscene, "cutscene_ended")
	cutscene.visible = false

func _on_Monument1_activated():
	_play_cutscene("PeredoSummoning", "play_movie_backwards")

func _on_MonumentBlue_activated():
	FarmUnlocked.visible = true
	get_tree().queue_delete(FarmLocked)

func _on_MonumentGreen_activated():
	TreeLocked.visible = false
	get_tree().queue_delete(TreeLocked)
	TreeUnlocked.visible = true

func _on_MonumentYellow_activated():
	RockLocked.translation.z = -33


func _on_MonumentPink_activated():
	get_tree().queue_delete(BarsLocked)