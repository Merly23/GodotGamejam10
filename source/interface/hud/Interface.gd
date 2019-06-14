extends CanvasLayer
class_name Interface

onready var player_state_label := $PlayerStateLabel

func update_player_state(state_name: String) -> void:
	player_state_label.text = state_name