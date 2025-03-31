class_name OnsetButton
extends Button

var onset: String: set = set_onset


func set_onset(_onset) -> void:
	onset = _onset
	self.text = onset
	if onset.length() < 3:
		remove_theme_font_size_override("font_size")
	elif onset.length() < 5:
		add_theme_font_size_override("font_size", 20)
	else:
		add_theme_font_size_override("font_size", 16)
		
