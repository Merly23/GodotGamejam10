extends Boss
class_name Clasher

export var attack_range := 80

func _ready():
	fsm.change_state("idle")

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("seek", "Seek")

func is_player_in_attack_range() -> bool:
	return _is_player_in_range(attack_range)

func _is_player_in_range(distance: int) -> bool:

	if not Global.Player:
		return false

	return global_position.distance_to(Global.Player.global_position) < distance