extends Node

var current_level := 0

var checkpoints := {}

var events := []

var has_virus := false

var deleted := false

func _ready():
	for i in 4:
		events.append([])

	_load_data()

func _exit_tree() -> void:
	_save_data()

func _load_data():

	var save_game = load("user://save_game.tres")

	if not save_game or deleted:
		return

	current_level = save_game.data["current_level"]
	checkpoints = save_game.data["checkpoints"]
	events = save_game.data["events"]

	has_virus = save_game.data["has_virus"]

	Audio.master_volume = save_game.data["master_volume"]
	Audio.music_volume = save_game.data["music_volume"]
	Audio.effects_volume = save_game.data["effects_volume"]

func _save_data():
	deleted = false

	var save_game := SaveGame.new()

	save_game.data["current_level"] = current_level
	save_game.data["checkpoints"] = checkpoints
	save_game.data["events"] = events

	save_game.data["has_virus"] = has_virus

	save_game.data["master_volume"] = Audio.master_volume
	save_game.data["music_volume"] = Audio.music_volume
	save_game.data["effects_volume"] = Audio.effects_volume

	ResourceSaver.save("user://save_game.tres", save_game)

func delete() -> void:
	deleted = true
	events = []

	for i in 4:
		events.append([])

	checkpoints = {}
	has_virus = false
