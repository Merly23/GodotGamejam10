extends Character
class_name Patrol

func _register_states():
	fsm.register_state("idle", "Idle")
	fsm.register_state("walk", "Walk")
	fsm.register_state("seek", "Seek")
	fsm.register_state("attack", "Attack")