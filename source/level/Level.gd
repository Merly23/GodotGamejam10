extends Node2D
class_name Level

export var id := 1

export var bottom_limit := 1000

onready var player := $Characters/Player
onready var terrain := $Terrain

onready var interface := $Interface as Interface
onready var game_cam := $GameCam

onready var cutscenes := $Cutscenes.get_children()
onready var checkpoints := $Checkpoints.get_children()

func _ready() -> void:

	for character in get_tree().get_nodes_in_group("Character"):
		character.connect("hurt", self, "_on_Character_hurt")

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
	get_tree().call_group("Character", "_set_disabled", true)
	# Global.Player.disabled = true

func _on_Cutscene_finished() -> void:
	yield(get_tree().create_timer(0.2), "timeout")
	interface.show()
	get_tree().call_group("Character", "_set_disabled", false)
	# Global.Player.disabled = false

func _on_Checkpoint_reached(id: int) -> void:
	Global.save_data[self.id] = id

func _on_Character_hurt(damage: int) -> void:
	if damage < 1:
		return
	# game_cam.screen_shake.start(0.05 * damage + 0.1, 10.0, 1.0 * damage, 1.0 * damage)

func _on_Player_health_changed(health) -> void:
	interface.update_health(health)
