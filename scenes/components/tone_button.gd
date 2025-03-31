class_name ToneButton
extends Button

var tone: String: set = set_tone


func set_tone(_tone) -> void:
	tone = _tone
	self.text = tone
