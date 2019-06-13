extends Node

var volume : float setget _set_volume

onready var tween := $Tween as Tween

onready var music_player := $MusicPlayer as AudioStreamPlayer

func _ready() -> void:
	_set_volume(1.0)

func play_music(stream: AudioStream) -> void:
	if $MusicPlayer.stream != stream:

		tween.interpolate_property(self, "volume", 1.0, 0.0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

		yield(tween, "tween_completed")

		$Music/Player.stream = stream
		$Music/Player.play()
		$Ambience.stop()

		tween.interpolate_property(self, "volume", 0.0, 1.0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

func _set_volume(value):
	volume = value
	AudioServer.set_bus_volume_db(0, linear2db(volume))
