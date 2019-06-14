extends KinematicBody2D
class_name Character

var motion := Vector2()

onready var upper := {
	anim = $Upper/AnimationPlayer,
	sprite = $Upper/Sprite,
	fsm = $Upper/FiniteStateMachine
}

onready var lower := {
	anim = $Upper/AnimationPlayer,
	sprite = $Upper/Sprite,
	fsm = $Upper/FiniteStateMachine
}

func _ready() -> void:
	_register_states()

func _register_states() -> void:
	print("Character::_ready->_setup_states: Overwrite!")

func _on_FiniteStateMachine_state_changed(state_name) -> void:
	print(name, ": ", state_name)
