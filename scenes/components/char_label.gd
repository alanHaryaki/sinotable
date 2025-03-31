class_name CharLabel
extends RichTextLabel


func populate(char: String, simplified: String, meaning: String) -> void:
	if char == simplified:
		self.text = "[b]{char}[/b]: {meaning}".format({"char": char, "meaning": meaning})
	else:
		self.text = "[b]{char}[/b]/[b]{simplified}[/b]: {meaning}".format({"char": char, "simplified": simplified, "meaning": meaning})
