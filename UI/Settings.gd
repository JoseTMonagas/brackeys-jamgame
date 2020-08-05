extends Control

enum Lang {ES,EN,FR,}


var modal = false
var input_key = null
var selected_action = null

onready var all_percent = $TabContainer/Audio/AudioAllCols/AllPercent
onready var all_slider = $TabContainer/Audio/AudioAllCols/AllSlider
onready var bgm_percent = $TabContainer/Audio/AudioBGMCols/BGMPercent
onready var bgm_slider = $TabContainer/Audio/AudioBGMCols/BGMSlider
onready var sfx_percent = $TabContainer/Audio/AudioSFXCols/SfxPercent
onready var sfx_slider = $TabContainer/Audio/AudioSFXCols/SfxSlider
onready var sense_value = $TabContainer/Control/MouseCols/SenseValue
onready var sense_slider = $TabContainer/Control/MouseCols/SenseSlider
onready var forward_button = $TabContainer/Control/ControlCols/Forward
onready var back_button = $TabContainer/Control/ControlCols/Backward
onready var left_button = $TabContainer/Control/ControlCols/Left
onready var right_button = $TabContainer/Control/ControlCols/Right

onready var input_dialog = $InputPopup

func _ready():
	_set_slider_label_value(sense_slider, sense_value, Global.load_setting("CONTROL", "MOUSE", 1))
	
	_set_key_text(forward_button, "SETTINGS_CONTROL_BUTTON_FORWARD", "ui_up")
	_set_key_text(back_button, "SETTINGS_CONTROL_BUTTON_BACKWARD", "ui_down")
	_set_key_text(left_button, "SETTINGS_CONTROL_BUTTON_LEFT", "ui_left")
	_set_key_text(right_button, "SETTINGS_CONTROL_BUTTON_RIGHT", "ui_right")
	
	_set_slider_label_value(all_slider, all_percent, Global.load_setting("AUDIO", "ALL", 100))
	_set_slider_label_value(bgm_slider, bgm_percent, Global.load_setting("AUDIO", "BGM", 100))
	_set_slider_label_value(sfx_slider, sfx_percent, Global.load_setting("AUDIO", "SFX", 100))


func _input(event):
	if modal:
		if event is InputEventKey:
			input_key = event
			input_dialog.dialog_text = OS.get_scancode_string(event.get_scancode_with_modifiers())


func _get_key_name(action_name):
	return OS.get_scancode_string(InputMap.get_action_list(action_name)[0].get_scancode_with_modifiers())


func _format_text_percent(value):
	return str(value * 100) + '%'


func _set_slider_label_value(slider, label, value):
	slider.value = value
	label.text = str(value)


func _set_key_text(key_button, string, action):
	key_button.text = tr(string) + ": " + str(_get_key_name(action))


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


func _on_Forward_pressed():
	modal = true
	selected_action = "ui_up"
	input_dialog.popup_centered_clamped()

func _on_Backward_pressed():
	modal = true
	selected_action = "ui_down"
	input_dialog.popup_centered_clamped()


func _on_Left_pressed():
	modal = true
	selected_action = "ui_left"
	input_dialog.popup_centered_clamped()


func _on_Right_pressed():
	modal = true
	selected_action = "ui_right"
	input_dialog.popup_centered_clamped()


func _on_InputPopup_confirmed():
	if input_key != null && selected_action != null:
		InputMap.action_erase_events(selected_action)
		InputMap.action_add_event(selected_action, input_key)
		match(selected_action):
			"ui_up":
				_set_key_text(forward_button, "SETTINGS_CONTROL_BUTTON_FORWARD", "ui_up")
			"ui_down":
				_set_key_text(back_button, "SETTINGS_CONTROL_BUTTON_BACKWARD", "ui_down")
			"ui_left":
				_set_key_text(left_button, "SETTINGS_CONTROL_BUTTON_LEFT", "ui_left")
			"ui_right":
				_set_key_text(right_button, "SETTINGS_CONTROL_BUTTON_RIGHT", "ui_right")
	input_key = null
	selected_action = null
	modal = false
