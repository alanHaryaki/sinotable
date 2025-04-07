extends TabContainer


func _ready() -> void:
	%ABOUT.show()


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("return"):
		self.hide()
	elif event.is_action_pressed("next"):
		self.current_tab = (self.current_tab + 1) % get_tab_count()
		
