extends Boss
class_name Clasher

func _ready():
	fsm.change_state("idle")

func _register_states() -> void:
	fsm.register_state("idle", "Idle")