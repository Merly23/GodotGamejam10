extends Node

var current_level := ""

func _ready():
	_load_data()

func _exit_tree():
	_save_data()

func _load_data():
	var file = File.new()

	if not file.open("user://data.save", File.READ) == OK:
		print("user://data.save odes not exist")
		return

	var data = parse_json(file.get_as_text())

	current_level = data["current_level"]

	Audio.master_volume = data["master_volume"]
	Audio.music_volume = data["music_volume"]
	Audio.effects_volume = data["effects_volume"]

	file.close()

func _save_data():
	var file = File.new()

	var data := {}

	data["current_level"] = current_level

	data["master_volume"] = Audio.master_volume
	data["music_volume"] = Audio.music_volume
	data["effects_volume"] = Audio.effects_volume

	file.open("user://data.save", File.WRITE)
	file.store_string(to_json(data))
	file.close()