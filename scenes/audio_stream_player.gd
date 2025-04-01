class_name SyllableAudioPlayer
extends AudioStreamPlayer


func play_syllable_audio(syllable: String) -> void:
	print(syllable)
	if FileAccess.file_exists("res://assets/audios/{syllable}.ogg".format({"syllable": syllable})):
		print("found")
		var sound = AudioStreamOggVorbis.load_from_file("res://assets/audios/{syllable}.ogg".format({"syllable": syllable}))
		self.stream = sound
		self.play()
