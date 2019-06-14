extends Character

func _ready() -> void:
	upper.fsm.host = self
	lower.fsm.host = self
	# upper.fsm.change_state("idle")
	# lower.fsm.change_state("idle")

func _register_states() -> void:
	# fsm.register_state("idle", "Idle")
	# fsm.register_state("walk", "Walk")
	pass