extends VBoxContainer

const ONSET_BUTTON_SCENE = preload("res://scenes/components/onset_button.tscn")

const ONSETS: Array = [
	"∅",
	"b", "p", "m", "f", "d", "t", "n", "l",
	"g", "k", "h", "z", "c", "s",
	"zh", "ch", "sh", "r", "j", "q", "x"
	]


func populate(main: Control) -> void:
	var button_group: ButtonGroup = ButtonGroup.new()
	button_group.allow_unpress = true
	for i: int in range(22):
		var onset_button: OnsetButton = ONSET_BUTTON_SCENE.instantiate()
		onset_button.onset = ONSETS[i]
		onset_button.button_group = button_group
		onset_button.pressed.connect(main.on_onset_button_pressed.bind(onset_button.onset))
		if i == 0:
			%Row4.add_child(onset_button)
		elif i < 9:
			%Row1.add_child(onset_button)
		elif i < 15:
			%Row2.add_child(onset_button)
		else:
			%Row3.add_child(onset_button)
