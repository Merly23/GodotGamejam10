extends Node2D

onready var interface := $Interface as Interface
onready var game_cam := $GameCam as GameCam

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		game_cam.screen_shake.start()

func _on_Player_state_changed(state_name) -> void:
	if interface:
		interface.update_player_state(state_name)
