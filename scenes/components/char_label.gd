class_name CharLabel
extends RichTextLabel

const SIMFANG_EMBOLDEN_PATH: String = "res://resources/simfang.embolden.tres"

var char: String
var simplified: String
var meaning: String

var style: int = 0: set = set_style


func populate(_char: String, _simplified: String, _meaning: String, _style: int = 1) -> void:
	char = _char
	simplified = _simplified
	meaning = _meaning.replace("[", "##").replace("]", "$$").replace("##", "[b][i]").replace("$$", "[/i][/b]").replace("<", "[b]").replace(">", "[/b]").replace("{", "[i]").replace("}", "[/i]").replace("(", "[code](").replace(")", ")[/code]")
	style = _style


func set_style(_style: int) -> void:
	style = _style
	if char == simplified:
		self.text = "[font=res://resources/simfang.embolden.tres][font_size=36]{char}[/font_size][/font]: {meaning}".format({"char": char, "meaning": meaning})
	else:
		match style:
			1:
				self.text = "[font=res://resources/simfang.embolden.tres][font_size=36]{char}[/font_size][/font]/[font=res://resources/simfang.embolden.tres][font_size=36]{simplified}[/font_size][/font]: {meaning}".format({"char": char, "simplified": simplified, "meaning": meaning})
			2:
				self.text = "[font=res://resources/simfang.embolden.tres][font_size=36]{simplified}[/font_size][/font]([font=res://resources/simfang.embolden.tres][font_size=36]{char}[/font_size][/font]): {meaning}".format({"char": char, "simplified": simplified, "meaning": meaning})
