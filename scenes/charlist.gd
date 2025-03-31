extends VBoxContainer

const CHAR_LABEL_SCENE: PackedScene = preload("res://scenes/components/char_label.tscn")


func clear() -> void:
	for child: Node in get_children():
		child.queue_free()


func display(list: Dictionary) -> void:
	clear()
	for char: String in list.keys():
		var char_label: CharLabel = CHAR_LABEL_SCENE.instantiate()
		char_label.populate(char, list[char]["simplified"], list[char]["meaning"])
		add_child(char_label)
