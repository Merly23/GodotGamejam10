extends Node2D

export var id := 1

export var bottom_limit := 1000

onready var player := $Characters/Player
onready var terrain := $Terrain

onready var interface := $Interface as Interface
onready var game_cam := $GameCam

onready var cutscenes := $Cutscenes.get_children()
onready var checkpoints := $Checkpoints.get_children()

func _ready() -> void:
	get_tree().call_group("Character", "set_bottom_limit", bottom_limit)
	game_cam.change_target(player)

	if Global.save_data[id] != -1:
		var new_position = checkpoints[Global.save_data[id]].global_position
		player.global_position = new_position
		game_cam.global_position = new_position


	for cutscene in cutscenes:
		cutscene.connect("started", self, "_on_Cutscene_started")
		cutscene.connect("finished", self, "_on_Cutscene_finished")

	for checkpoint in checkpoints:
		checkpoint.connect("reached", self, "_on_Checkpoint_reached")

func _on_Cutscene_started() -> void:
	interface.hide()
	Global.Player.disabled = true

func _on_Cutscene_finished() -> void:
	yield(get_tree().create_timer(0.2), "timeout")
	interface.show()
	Global.Player.disabled = false

func _on_Checkpoint_reached(id: int) -> void:
	Global.save_data[self.id] = id