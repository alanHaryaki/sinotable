extends VBoxContainer

signal settings_applied


const CHOICE_BUTTON_SCENE = preload("res://scenes/components/choice_button.tscn")

const STYLES: Array = ["1", "2"]

const RANGES: Array = [
	1,
	2,
	3,
	4,
	5,
	6,
	0,
	]


var style_buttons: ButtonGroup
var range_buttons: ButtonGroup

var current_settings: Dictionary


func populate(main: Control) -> void:
	style_buttons = ButtonGroup.new()
	range_buttons = ButtonGroup.new()
	%ExampleLabel.populate("漢", Global.dict["漢"]["simplified"], Global.dict["漢"]["meaning"])
	for i: int in range(2):
		var choice_button: ChoiceButton = CHOICE_BUTTON_SCENE.instantiate()
		choice_button.choice_index = STYLES[i]
		choice_button.text = str(STYLES[i])
		choice_button.button_group = style_buttons
		choice_button.pressed.connect(on_style_button_pressed.bind(STYLES[i]))
		%StyleOptionsContainer.add_child(choice_button)
	for i: int in range(7):
		var choice_button: ChoiceButton = CHOICE_BUTTON_SCENE.instantiate()
		choice_button.text = "HSK" + str(RANGES[i]) if RANGES[i] != 0 else "ALL"
		choice_button.button_group = range_buttons
		choice_button.pressed.connect(on_range_button_pressed.bind(RANGES[i]))
		%RangeOptionsContainer.add_child(choice_button)


func load_settings() -> void:
	current_settings = Global.settings.duplicate(true)
	for button: ChoiceButton in style_buttons.get_buttons():
		if button.text == current_settings["style"]:
			button.button_pressed = true
	for button: ChoiceButton in range_buttons.get_buttons():
		if button.text == current_settings["range"]:
			button.button_pressed = true


func on_style_button_pressed(option: int) -> void:
	current_settings["style"] = option
	%ExampleLabel.style = option


func on_range_button_pressed(option: int) -> void:
	current_settings["range"] = option


func on_apply_button_pressed() -> void:
	Global.settings = current_settings.duplicate(true)
	settings_applied.emit()
