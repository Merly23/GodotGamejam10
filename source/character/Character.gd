extends KinematicBody2D
class_name Character

signal state_changed(state_name)

signal health_changed(health)
signal died

var motion := Vector2()

var health setget _set_health

export var team_number := 0

export var max_health := 2

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

func hurt(damage) -> void:
	_set_health(health - damage)

func play(anim_name: String) -> void:
#	upper.anim.travel(anim_name)
#	lower.anim.travel(anim_name)
	upper.anim_player.play(anim_name)
	lower.anim_player.play(anim_name)

func play_upper(anim_name: String) -> void:
#	upper.anim.travel(anim_name)
	upper.anim_player.play(anim_name)

func play_lower(anim_name: String) -> void:
#	lower.anim.travel(anim_name)
	lower.anim_player.play(anim_name)

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

func _set_health(value) -> void:
	health = clamp(value, 0, max_health)
	emit_signal("health_changed")
	if health == 0:
		emit_signal("died")

func _on_FiniteStateMachine_state_changed(state_name) -> void:
	emit_signal("state_changed", state_name)

