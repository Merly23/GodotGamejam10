extends Boss
class_name Clasher

export var vision := 200
export var ram_range := 150
export var bite_range := 75
export var ram_damage := 20
export var bite_damage := 30

func _ready():
	fsm.change_state("idle")

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("seek", "Seek")
	fsm.register_state("ram", "Ram")
	fsm.register_state("bite", "Bite")
	fsm.register_state("stunned", "Stunned")

func bite() -> void:
	pass

func ram() -> void:
	pass

func is_player_in_vision() -> bool:
	return _is_player_in_range(vision)

func is_player_in_ram_range() -> bool:
	return _is_player_in_range(ram_range)

func is_player_in_bite_range() -> bool:
	return _is_player_in_range(bite_range)

func _is_player_in_range(distance: int) -> bool:

	if not Global.Player:
		return false

	return global_position.distance_to(Global.Player.global_position) < distance