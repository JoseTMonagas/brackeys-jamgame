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


func _play_cutscene(node_name, animation_name, backwards=false):
	creature.force_rest = true
	var cutscene = cutscenes.get_node(node_name)
	cutscene.visible = true
	if backwards:
		cutscene.play_animation_backwards(animation_name)
	else:
		cutscene.play_animation(animation_name)
	yield(cutscene, "cutscene_ended")
	cutscene.visible = false


func _on_Monument1_activated():
	_play_cutscene("PeredoSummoning", "play_movie_backwards")
	creature.queue_free()
	Global.change_scene("res://UI/Victory.tscn")


func _on_MonumentBlue_activated():
	_play_cutscene("FarmDestruction", "PlayMovieBackwards", true)
	FarmUnlocked.visible = true
	get_tree().queue_delete(FarmLocked)


func _on_MonumentGreen_activated():
	_play_cutscene("TreeDestruction", "PlayMovieBackwards", true)
	TreeLocked.visible = false
	get_tree().queue_delete(TreeLocked)
	TreeUnlocked.visible = true


func _on_MonumentYellow_activated():
	_play_cutscene("MovingRockAnimation", "PlayMovieBackwards", true)
	RockLocked.translation.z = -33


func _on_MonumentPink_activated():
	_play_cutscene("BarsSummonning", "PlayMovieBackwards", false)
	get_tree().queue_delete(BarsLocked)


func _on_Return_mouse_entered():
	$Hover.play()


func _on_MainMenu_mouse_entered():
	$Hover.play()


func _on_Quit_mouse_entered():
	$Hover.play()


func _on_Return_pressed():
	$Pressed.play()
	$Menu.visible = false
	

func _on_MainMenu_pressed():
	$Pressed.play()
	Global.change_scene(Global.MAIN_MENU)


func _on_Quit_pressed():
	$Pressed.play()
	get_tree().quit()


func _on_Player_toggle_menu():
	$Menu.visible = !$Menu.visible
