class_name SyllableButton
extends Button

signal syllable_pressed(_syllable)

const TONE_INDICES: Dictionary = {
	"平": 0,
	"升": 1,
	"上": 2,
	"去": 3,
}

var rime: String: set = set_rime
var is_valid_rime: bool = false
var onset: String = ""
var tone: String = ""
var syllable: String


func set_rime(_rime: String) -> void:
	rime = _rime
	if rime in Global.VALID_RIMES:
		self.disabled = false
		is_valid_rime = true
	else:
		self.disabled = true


func update_syllable() -> void:
	
	syllable = add_onset(rime, onset)
	
	if syllable.length() < 4:
		remove_theme_font_size_override("font_size")
	else:
		add_theme_font_size_override("font_size", max(40 - 4 * syllable.length(), 16))
	
	syllable = add_tone(syllable, tone)
	
	self.text = syllable
	
	check_validity()


func check_validity() -> void:
	if not onset and tone != "輕":
		if syllable in Global.VALID_RIMES:
			self.disabled = false
		else:
			self.disabled = true
	elif not tone:
		if syllable in Global.valid_neutral_syllables:
			self.disabled = false
		else:
			self.disabled = true
	else:
		if syllable in Global.dict:
			self.disabled = false
		else:
			self.disabled = true


func add_onset(_rime: String, _onset: String) -> String:
	if not is_valid_rime:
		return "∅"
	if _onset == "":
		return _rime
	_rime = _rime.replace("ê", "e")
	if _onset == "∅":
		match _rime[0]:
			"-i":
				return "∅"
			"i":
				return "y" + _rime if _rime.length() == 1 or _rime[1] == "n" else "y" + _rime.right(_rime.length() - 1)
			"u":
				return "w" + _rime if _rime.length() == 1 else "w" + _rime.right(_rime.length() - 1)
			"ü":
				return "yu" + _rime.right(_rime.length() - 1)
			_:
				return _rime
	elif _onset in ["z", "c", "s", "zh", "ch", "sh"] and _rime in ["i", "-i"]:
		match _rime:
			"i":
				return "∅"
			_:
				return _onset + "i"
	elif _onset in ["b", "p", "m", "f"] and _rime in ["o", "uo"]:
		match _rime:
			"o":
				return "∅"
			_:
				return _onset + "o"
	elif _onset in ["j", "q", "x"] and _rime in ["u", "ü"]:
		match _rime:
			"u":
				return "∅"
			_:
				return _onset + "u"
	else:
		match _rime:
			"iou":
				return _onset + "iu"
			"uei":
				return _onset + "ui"
			"uen":
				return _onset + "un"
			_:
				return _onset + _rime


func add_tone(_syllable: String, _tone: String) -> String:
	if not is_valid_rime or _syllable == "∅":
		return "∅"
	if _tone == "輕" or _tone == "":
		return _syllable
	var vowels: String = divide(_syllable)[1]
	var final_consonants: String = divide(_syllable)[2]
	if vowels.length() == 1:
		return _syllable.replace(vowels, Global.VOWELS_WITH_DIACTRICS[vowels][TONE_INDICES[_tone]])
	else:
		if "a" in vowels:
			return _syllable.replace("a", Global.VOWELS_WITH_DIACTRICS["a"][TONE_INDICES[_tone]])
		elif "e" in vowels:
			return _syllable.replace("e", Global.VOWELS_WITH_DIACTRICS["e"][TONE_INDICES[_tone]])
		elif "o" in vowels:
			return _syllable.replace("o", Global.VOWELS_WITH_DIACTRICS["o"][TONE_INDICES[_tone]])
		else:
			return _syllable.replace(vowels[-1], Global.VOWELS_WITH_DIACTRICS[vowels[-1]][TONE_INDICES[_tone]])



func divide(_syllable: String) -> Array:
	var vowels: String = ""
	for char: String in _syllable:
		if char in ["a", "e", "i", "o", "u", "ü"]:
			vowels += char
		elif vowels.length() > 0:
			break
	return [_syllable.split(vowels)[0], vowels, _syllable.split(vowels)[1]]


func on_pressed() -> void:
	syllable_pressed.emit(syllable)
