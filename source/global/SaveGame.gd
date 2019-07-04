extends Node

var current_level := 0

var checkpoints := {}

var events := {}

var has_virus := false

func _ready():
	events[int(1)] = []
	events[int(2)] = []
	events[int(3)] = []

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
	checkpoints = data["checkpoints"]
	events = data["events"]

	has_virus = data["has_virus"]

	Audio.master_volume = data["master_volume"]
	Audio.music_volume = data["music_volume"]
	Audio.effects_volume = data["effects_volume"]

	file.close()

func _save_data():
	var file = File.new()

	var data := {}

	data["current_level"] = current_level
	data["checkpoints"] = checkpoints
	data["events"] = events

	data["has_virus"] = has_virus

	data["master_volume"] = Audio.master_volume
	data["music_volume"] = Audio.music_volume
	data["effects_volume"] = Audio.effects_volume

	file.open("user://data.save", File.WRITE)
	file.store_string(to_json(data))
	file.close()

func delete() -> void:
	events[int(1)] = []
	events[int(2)] = []
	events[int(3)] = []
	checkpoints = {}
	has_virus = false
