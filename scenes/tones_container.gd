extends HBoxContainer

const TONE_BUTTON_SCENE: PackedScene = preload("res://scenes/components/tone_button.tscn")

const TONES: Array = [
	"平",
	"升",
	"上",
	"去",
	"輕",
	]

func populate(main: Control) -> void:
	var button_group: ButtonGroup = ButtonGroup.new()
	button_group.allow_unpress = true
	for i: int in range(5):
		var tone_button: ToneButton = TONE_BUTTON_SCENE.instantiate()
		tone_button.tone = TONES[i]
		tone_button.button_group = button_group
		tone_button.pressed.connect(main.on_tone_button_pressed.bind(tone_button.tone))
		add_child(tone_button)
