extends Control

const DICT_PATH: String = "res://resources/dict.json"

var current_onset: String = ""
var current_tone: String = ""


func _ready() -> void:
	load_dict()
	get_valid_neutral_syllables()
	%SyllablesContainer.populate(self)
	%OnsetsContainer.populate(self)
	%TonesContainer.populate(self)
	%SettingsContainer.populate(self)
	%SettingsContainer.load_settings()
	%SettingsContainer.settings_applied.connect(on_settings_applied)
	%InfoPanel.visible = false


func load_dict() -> void:
	Global.dict = JSON.parse_string(FileAccess.get_file_as_string(DICT_PATH))


func get_valid_neutral_syllables() -> void:
	for syllable: String in Global.dict.keys():
		var neutral_syllable: String = ""
		for char: String in syllable:
			if char in Global.TONE_NEUTRAL_MAP:
				neutral_syllable += Global.TONE_NEUTRAL_MAP[char]
			else:
				neutral_syllable += char
		if neutral_syllable not in Global.valid_neutral_syllables:
			Global.valid_neutral_syllables.append(neutral_syllable)


func on_onset_button_pressed(onset: String) -> void:
	if current_onset == onset:
		current_onset = ""
	else:
		current_onset = onset
	
	%SyllablesContainer.update_onset(current_onset)


func on_tone_button_pressed(tone: String) -> void:
	if current_tone == tone:
		current_tone = ""
	else:
		current_tone = tone
	
	%SyllablesContainer.update_tone(current_tone)


func on_syllable_pressed(syllable: String) -> void:
	if current_onset and current_tone:
		%DisplayContainer.display(syllable)
		%SyllableAudioPlayer.play_syllable_audio(syllable)


func on_settings_applied() -> void:
	for child: Node in %Charlist.get_children():
		if child is CharLabel:
			(child as CharLabel).set_style(Global.settings["style"])


func on_info_button_pressed() -> void:
	%InfoPanel.visible = not %InfoPanel.visible
	%SettingsContainer.load_settings()
