extends Node

var save_data = [ -1, -1, -1, -1 ]

var current_level := ""

var has_virus = false

const GRAVITY = 2000
const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)

var Player = null
var Terrain = null

func _ready():
	_load_score_data()

func _exit_tree():
	_save_score_data()

func _load_score_data():
	var file = File.new()

	if not file.open("user://data.save", File.READ) == OK:
		print("user://score.save odes not exist")
		return

	var dict = parse_json(file.get_as_text())

	current_level = dict.level

	file.close()

func _save_score_data():
	var file = File.new()

	var dict = {
		level = current_level,
	}

	file.open("user://data.save", File.WRITE)
	file.store_string(to_json(dict))
	file.close()