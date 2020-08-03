extends Node

const MAIN_MENU = "res://UI/Start.tscn"
const SETTINGS = "res://UI/Settings.tscn"
const SAVE_FILE = "user://josoro2000.save"
const CONFIGURATION_FILE = "user://josoro2000.cfg"


func _ready():
	_initialize()


func save_setting(section, key, value):
	var configuration_file = ConfigFile.new()
	configuration_file.load(CONFIGURATION_FILE)
	configuration_file.set_value(section, key, value)
	return


func load_setting(section, key, default):
	var configuration_file = ConfigFile.new()
	configuration_file.load(CONFIGURATION_FILE)
	return configuration_file.get_value(section, key, default)


func change_scene(path):
	get_tree().change_scene(path)


func quit():
	get_tree().quit()


func set_volume(bus, db):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), db)


func _initialize():
	for bus in ["Master", "Bgm", "Sfx"]:
		var db = linear2db(load_setting("AUDIO", str(bus).to_upper(), 1))
		set_volume(str(bus), db)
	TranslationServer.set_locale(load_setting("LANGUAGE", "SELECTED", "en"))
