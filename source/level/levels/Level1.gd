extends Level

func _ready() -> void:
	Audio.play_song("Level1")
	Glitch.level = 0
