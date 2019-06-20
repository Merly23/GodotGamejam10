extends Node

export var master_volume := 1.0 setget _set_master_volume
export var music_volume := 1.0 setget _set_music_volume
export var effects_volume := 1.0 setget _set_effects_volume

onready var mixing_desk := $MixingDeskMusic

onready var sfx = {
	player_hurt = $SFX/Player/Hurt,
	player_blink_start = $SFX/Player/BlinkStart,
	player_blink_end = $SFX/Player/BlinkEnd,
	button_hover = $SFX/Button/Hover,
	button_pressed = $SFX/Button/Pressed,
	menu_open = $SFX/Menu/Open,
	menu_close = $SFX/Menu/Close,
	gun_shot = $SFX/GunShot
}

func _ready() -> void:
	mixing_desk._init_song("menuMusic")
	mixing_desk._init_song("levelMusic")

func play_song(song: String) -> void:
	mixing_desk._change_song(song)

func play_sfx(effect_name, pitch_from := 0.0, pitch_to := 0.0):

	if pitch_from and pitch_to:
		sfx[effect_name].pitch = rand_range(pitch_from, pitch_to)

	sfx[effect_name].play()

func _set_master_volume(value):
	master_volume = value
	AudioServer.set_bus_volume_db(0, linear2db(master_volume))

func _set_music_volume(value):
	music_volume = value
	AudioServer.set_bus_volume_db(1, linear2db(music_volume))


func _set_effects_volume(value):
	effects_volume = value
	AudioServer.set_bus_volume_db(2, linear2db(effects_volume))