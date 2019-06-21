extends Character
class_name Patrol

export var vision := 350
export var shoot_range := 200

func _ready() -> void:
	fsm.change_state("idle")

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("walk", "Walk")
	fsm.register_state("seek", "Seek")
	fsm.register_state("shoot", "Shoot")

func is_player_in_shoot_range() -> bool:

	if not Global.Player:
		return false

	return global_position.distance_to(Global.Player.global_position) < shoot_range

func is_player_in_vision() -> bool:

	if not Global.Player:
		return false

	return global_position.distance_to(Global.Player.global_position) < vision