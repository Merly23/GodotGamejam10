extends Character

func _ready() -> void:
	Global.Player = self
	fsm.change_state("idle")

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("walk", "Walk")
	fsm.register_state("fall", "Fall")
	fsm.register_state("jump", "Jump")