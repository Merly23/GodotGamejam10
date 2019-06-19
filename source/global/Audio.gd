extends Node

var master_volume : float setget _set_master_volume

onready var mixing_desk := $MixingDeskMusic

func _ready() -> void:
	mixing_desk._init_song("menuMusic")
	mixing_desk._init_song("levelMusic")
	_set_master_volume(0.7)

func play_song(song: String) -> void:
	mixing_desk._play(song)

func _set_master_volume(value):
	master_volume = value
	AudioServer.set_bus_volume_db(0, linear2db(master_volume))
