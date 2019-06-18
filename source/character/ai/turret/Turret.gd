extends Character

export var vision := 200

func _ready() -> void:
	fsm.change_state("idle")

func _register_states():
	fsm.register_state("idle", "Idle")
	fsm.register_state("shoot", "Shoot")

func is_player_in_vision() -> bool:

	if not Global.Player:
		return false

	return (global_position - Global.Player.global_position).length() < vision