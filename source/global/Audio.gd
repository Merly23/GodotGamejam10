extends Node

export var master_volume := 1.0 setget _set_master_volume
export var music_volume := 1.0 setget _set_music_volume
export var effects_volume := 1.0 setget _set_effects_volume

onready var mixing_desk := $MixingDeskMusic

func _ready() -> void:
	mixing_desk._init_song("menuMusic")
	mixing_desk._init_song("levelMusic")

func play_song(song: String) -> void:
	mixing_desk._play(song)

func _set_master_volume(value):
	master_volume = value
	AudioServer.set_bus_volume_db(0, linear2db(master_volume))


func _set_music_volume(value):
	music_volume = value
	AudioServer.set_bus_volume_db(1, linear2db(music_volume))


func _set_effects_volume(value):
	effects_volume = value
	AudioServer.set_bus_volume_db(2, linear2db(effects_volume))