extends Node2D

onready var interface := $Interface as Interface
onready var game_cam := $GameCam as GameCam

func _ready() -> void:
	pass # Global.Player.disabled = true

func _on_Player_state_changed(state_name) -> void:
	if interface:
		interface.update_player_state(state_name)
