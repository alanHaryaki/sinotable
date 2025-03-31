extends VBoxContainer


func display(syllable: String) -> void:
	%PinyinLabel.text = syllable
	%Charlist.display(Global.dict[syllable])
