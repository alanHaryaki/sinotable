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


func _draw() -> void:
	var points: PackedVector2Array = []
	for i: int in range(5):
		points.append(Vector2(64 * i, 0))
		points.append(Vector2(64 * i, 40))
	draw_multiline(points, Color.BLACK, 0.3, true)
	var thick_points: PackedVector2Array = [
		Vector2(0, 0), Vector2(64 * 5, 0),
		Vector2(0, 40), Vector2(64 * 5, 40),
		Vector2(0, 0), Vector2(0, 40),
		Vector2(64 * 5, 0), Vector2(64 * 5, 40),
	]
	draw_multiline(thick_points, Color.BLACK, 2, true)
