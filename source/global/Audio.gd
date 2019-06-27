extends Node

export var master_volume := 1.0 setget _set_master_volume
export var music_volume := 1.0 setget _set_music_volume
export var effects_volume := 1.0 setget _set_effects_volume

onready var music_player := $MusicPlayer as AudioStreamPlayer

onready var music = {
	menu_music = preload("res://audio/music/menuLoop.wav"),
	game_music = preload("res://audio/music/combatLoop.wav")
}

onready var sfx = {
	player_hurt = $SFX/Player/Hurt,
	player_jump = $SFX/Player/Jump,
	player_land = $SFX/Player/Land,
	player_stop = $SFX/Player/Stop,
	player_step = $SFX/Player/Step,
	player_slash = $SFX/Player/Slash,
	player_blink_start = $SFX/Player/BlinkStart,
	player_blink_end = $SFX/Player/BlinkEnd,
	player_slow_motion_start = $SFX/Player/SlowMotionStart,
	player_slow_motion_end = $SFX/Player/SlowMotionEnd,
	button_hover = $SFX/Button/Hover,
	button_pressed = $SFX/Button/Pressed,
	menu_open = $SFX/Menu/Open,
	menu_close = $SFX/Menu/Close,
	gun_shot = $SFX/GunShot,
	glitch = $SFX/Glitch,
	type = $SFX/Type,
	checkpoint = $SFX/Checkpoint,
	tick1 = $SFX/Tick1,
	tick2 = $SFX/Tick2,
	tick3 = $SFX/Tick3,
	tick4 = $SFX/Tick4
}

func play_music(song: String) -> void:

	if music_player.stream == music[song]:
		return

	music_player.stream = music[song]
	music_player.play()

func play_sfx(effect_name, pitch_from := 0.0, pitch_to := 0.0):

	if not sfx.has(effect_name):
		print("could not find sound: ", effect_name)
		return

	if pitch_from and pitch_to:
		sfx[effect_name].pitch = rand_range(pitch_from, pitch_to)

	if effect_name == "tick":
		effect_name += str(randi() % 4 + 1)

	if effect_name == "type" or effect_name == "glitch":
		randomize()
		sfx[effect_name].pitch_scale = rand_range(0.9, 1.4)

	sfx[effect_name].play()

func db2int(db: float) -> int:
	return int(db2linear(db) * 10)

func linear2int(linear: float) -> int:
	return int(linear * 10)

func int2linear(integer: int) -> float:
	return float(integer) / 10.0

func int2db(integer: int) -> float:
	return linear2db(linear2int(integer))

func _set_master_volume(value):
	master_volume = value
	AudioServer.set_bus_volume_db(0, linear2db(master_volume))

func _set_music_volume(value):
	music_volume = value
	AudioServer.set_bus_volume_db(1, linear2db(music_volume))

func _set_effects_volume(value):
	effects_volume = value
	AudioServer.set_bus_volume_db(2, linear2db(effects_volume))