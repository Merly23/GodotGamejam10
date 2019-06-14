extends Node2D

onready var interface := $Interface as Interface

func _on_Player_state_changed(state_name) -> void:
	if interface:
		interface.update_player_state(state_name)
