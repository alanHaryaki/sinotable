extends VBoxContainer

const CHAR_LABEL_SCENE: PackedScene = preload("res://scenes/components/char_label.tscn")


func clear() -> void:
	for child: Node in get_children():
		child.queue_free()


func display(list: Dictionary) -> void:
	clear()
	for char: String in list.keys():
		if Global.settings["range"] == 0:
			pass
		elif int(list[char]["level"]) <= Global.settings["range"]:
			pass
		else:
			continue
		var char_label: CharLabel = CHAR_LABEL_SCENE.instantiate()
		char_label.populate(char, list[char]["simplified"], list[char]["meaning"], Global.settings["style"])
		add_child(char_label)
