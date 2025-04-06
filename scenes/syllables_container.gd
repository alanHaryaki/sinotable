extends GridContainer

const SYLLABLE_BUTTON_SCENE: PackedScene = preload("res://scenes/components/syllable_button.tscn")
const HEADER_LABEL_SCENE: PackedScene = preload("res://scenes/components/header_label.tscn")

const COLUMNS: Array = [
	"", 
	"∅",
	"-i",
	"-u",
	"-n",
	"-ng"
	]
	
const ROWS: Array = [
	"", 
	"a","o","e","ê","i","u","ü",
	"-i","er",
	"ia","iê","io",
	"ua","ue","uo",
	"üa","üê"
	]


func populate(main: Control) -> void:
	for i: int in range(108):
		if i < 6:
			var header_label: HeaderLabel = HEADER_LABEL_SCENE.instantiate()
			header_label.text = COLUMNS[i]
			add_child(header_label)
		elif i % 6 == 0:
			var header_label: HeaderLabel = HEADER_LABEL_SCENE.instantiate()
			header_label.text = ROWS[i / 6]
			add_child(header_label)
		else:
			var syllable_button: SyllableButton = SYLLABLE_BUTTON_SCENE.instantiate()
			syllable_button.rime = get_rime(ROWS[i / 6], COLUMNS[i % 6])
			syllable_button.update_syllable()
			syllable_button.syllable_pressed.connect(main.on_syllable_pressed)
			add_child(syllable_button)


func get_rime(row: String, column: String) -> String:
	if row[-1] == "a" and column == "-u":
		return row + "o"
	return row + column.right(column.length() - 1)


func update_onset(onset: String) -> void:
	for child: Node in get_children():
		if child is SyllableButton:
			(child as SyllableButton).onset = onset
			(child as SyllableButton).update_syllable()


func update_tone(tone: String) -> void:
	for child: Node in get_children():
		if child is SyllableButton:
			(child as SyllableButton).tone = tone
			(child as SyllableButton).update_syllable()


func _draw() -> void:
	var points: PackedVector2Array = []
	for i in range(6):
		points.append(Vector2(64 * i, 0))
		points.append(Vector2(64 * i, 40 * 18))
	for i in range(18):
		points.append(Vector2(0, 40 * i))
		points.append(Vector2(64 * 6, 40 * i))
	draw_multiline(points, Color.BLACK, 0.3, true)
	var thick_points: PackedVector2Array = [
		Vector2(0, 0), Vector2(64 * 6, 0),
		Vector2(0, 40), Vector2(64 * 6, 40),
		Vector2(0, 40 * 8), Vector2(64 * 6, 40 * 8),
		Vector2(0, 40 * 9), Vector2(64 * 6, 40 * 9),
		Vector2(0, 40 * 10), Vector2(64 * 6, 40 * 10),
		Vector2(0, 40 * 13), Vector2(64 * 6, 40 * 13),
		Vector2(0, 40 * 16), Vector2(64 * 6, 40 * 16),
		Vector2(0, 40 * 18), Vector2(64 * 6, 40 * 18),
		Vector2(0, 0), Vector2(0, 40 * 18),
		Vector2(64, 0), Vector2(64, 40 * 18),
		Vector2(64 * 6, 0), Vector2(64 * 6, 40 * 18),
	]
	draw_multiline(thick_points, Color.BLACK, 2, true)
