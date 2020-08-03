extends Control

enum Lang {ES,EN,FR,}


onready var all_percent = $ScrollContainer/Rows/AudioAllCols/AllPercent
onready var all_slider = $ScrollContainer/Rows/AudioAllCols/AllSlider
onready var bgm_percent = $ScrollContainer/Rows/AudioBGMCols/BGMPercent
onready var bgm_slider = $ScrollContainer/Rows/AudioBGMCols/BGMSlider
onready var sfx_percent = $ScrollContainer/Rows/AudioSFXCols/SfxPercent
onready var sfx_slider = $ScrollContainer/Rows/AudioSFXCols/SfxSlider
onready var sense_value = $ScrollContainer/Rows/MouseCols/SenseValue
onready var sense_slider = $ScrollContainer/Rows/MouseCols/SenseSlider


func _format_text_percent(value):
	return str(value * 100) + '%'


func _on_AllSlider_value_changed(value):
	all_percent.text = _format_text_percent(value)
	Global.set_volume("Master", linear2db(value))
	Global.save_setting("AUDIO", "ALL", value)

func _on_BGMSlider_value_changed(value):
	bgm_percent.text = _format_text_percent(value)
	Global.set_volume("Bgm", linear2db(value))
	Global.save_setting("AUDIO", "BGM", value)

func _on_SfxSlider_value_changed(value):
	sfx_percent.text = _format_text_percent(value)
	Global.set_volume("Sfx", linear2db(value))
	Global.save_setting("AUDIO", "SFX", value)

func _on_SenseSlider_value_changed(value):
	sense_value.text = str(value)
	Global.save_setting("MOUSE", "SENSITIVITY", value)


func _on_EnglishButton_pressed():
	TranslationServer.set_locale("en")
	Global.save_setting("AUDIO", "ALL", Lang.EN)

func _on_SpanishButton_pressed():
	TranslationServer.set_locale("es")
	Global.save_setting("LANGUAGE", "SELECTED", Lang.ES)

func _on_FrenchButton_pressed():
	TranslationServer.set_locale("fr")
	Global.save_setting("AUDIO", "ALL", Lang.FR)

func _on_Return_pressed():
	Global.change_scene(Global.MAIN_MENU)
