extends KinematicBody2D
class_name Character

signal state_changed(state_name)

var motion := Vector2()

export var team_name := 0

onready var upper := {
	anim_player = $Upper/AnimationPlayer,
	anim_tree = $Upper/AnimationTree,
	anim = $Upper/AnimationTree.get("parameters/playback"),
	sprite = $Upper/Sprite
}

onready var lower := {
	anim_player = $Lower/AnimationPlayer,
	anim_tree = $Lower/AnimationTree,
	anim = $Lower/AnimationTree.get("parameters/playback"),
	sprite = $Lower/Sprite
}

onready var fsm := $FiniteStateMachine as FiniteStateMachine

func _ready() -> void:
	_register_host()
	_register_states()

func _register_states() -> void:
	print("Character::_ready->_setup_states: Overwrite!")

func play(anim_name: String) -> void:
	upper.anim.travel(anim_name)
	lower.anim.travel(anim_name)

func play_upper(anim_name: String) -> void:
	upper.anim.travel(anim_name)

func play_lower(anim_name: String) -> void:
	lower.anim.travel(anim_name)

func flip() -> void:
	if is_flipped():
		flip_right()
	else:
		flip_left()

func flip_left() -> void:
	upper.sprite.flip_v = true
	lower.sprite.flip_v = true

func flip_right() -> void:
	upper.sprite.flip_v = false
	lower.sprite.flip_v = false

func is_flipped() -> bool:
	return lower.sprite.flip_v

func _register_host() -> void:
	fsm.host = self

func _on_FiniteStateMachine_state_changed(state_name) -> void:
	emit_signal("state_changed", state_name)

