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
	for i: int in range(5):
		var place_holder: Control = Control.new()
		place_holder.custom_minimum_size = Vector2(64, 40)
		if i == 0:
			%Row2.add_child(place_holder)
		elif i == 1:
			%Row3.add_child(place_holder)
		else:
			%Row4.add_child(place_holder)


func _draw() -> void:
	var points: PackedVector2Array = []
	for i: int in range(1, 8):
		points.append(Vector2(64 * i, 0))
		points.append(Vector2(64 * i, 40 * 3))
	draw_multiline(points, Color.BLACK, 0.3, true)
	var thick_points: PackedVector2Array = [
		Vector2(0, 0), Vector2(64 * 8, 0),
		Vector2(0, 40), Vector2(64 * 8, 40),
		Vector2(0, 40 * 2), Vector2(64 * 7, 40 * 2),
		Vector2(0, 40 * 3), Vector2(64 * 7, 40 * 3),
		Vector2(64 * 4, 40 * 4), Vector2(64 * 5, 40 * 4),
		Vector2(0, 0), Vector2(0, 40),
		Vector2(0, 40 * 2), Vector2(0, 40 * 3),
		Vector2(64, 40), Vector2(64, 40 * 2),
		Vector2(64 * 4, 0), Vector2(64 * 4, 40 * 4),
		Vector2(64 * 5, 40 * 3), Vector2(64 * 5, 40 * 4),
		Vector2(64 * 7, 40), Vector2(64 * 7, 40 * 3),
		Vector2(64 * 8, 0), Vector2(64 * 8, 40),
	]
	draw_multiline(thick_points, Color.BLACK, 2, true)
