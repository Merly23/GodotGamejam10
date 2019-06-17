extends KinematicBody2D
class_name Character

signal state_changed(state_name)

signal health_changed(health)
signal died

var motion := Vector2()

var health setget _set_health

var disabled := false setget _set_disabled

export var team_number := 0

export var max_health := 2

onready var anim_player := $AnimationPlayer as AnimationPlayer

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

onready var hooks := {
	dust_left = $Hooks/DustLeft,
	dust_center = $Hooks/DustCenter,
	dust_right = $Hooks/DustRight
}

onready var hit_area := $HitArea as Area2D

onready var fsm := $FiniteStateMachine as FiniteStateMachine

func _ready() -> void:
	_register_host()
	_register_states()
	fsm.register_state("die", "Die")
	health = max_health

func _register_states() -> void:
	print("Character::_ready->_setup_states: Overwrite!")

func hurt(damage) -> void:
	_set_health(health - damage)
	anim_player.play("hurt")

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

func spawn_jump_dust() -> void:
	var dust = Instance.Dust()
	dust.global_position = hooks.dust_center.global_position
	get_tree().root.add_child(dust)
	dust.play("jump")

func spawn_dash_dust() -> void:
	var dust = Instance.Dust()
	dust.global_position = hooks.dust_center.global_position
	get_tree().root.add_child(dust)
	dust.play("dash", is_flipped())

func spawn_stop_dust() -> void:
	var dust = Instance.Dust()
	get_tree().root.add_child(dust)
	if is_flipped():
		dust.global_position = hooks.dust_left.global_position
	else:
		dust.global_position = hooks.dust_right.global_position
	dust.play("land", is_flipped())

func spawn_land_dust() -> void:
	var dust_left = Instance.Dust()
	var dust_right = Instance.Dust()

	get_tree().root.add_child(dust_left)
	get_tree().root.add_child(dust_right)

	dust_left.global_position = hooks.dust_left.global_position
	dust_right.global_position = hooks.dust_right.global_position

	dust_left.play("land", true)
	dust_right.play("land")


func flip() -> void:
	if is_flipped():
		flip_right()
	else:
		flip_left()

func flip_left() -> void:
	upper.sprite.flip_v = true
	lower.sprite.flip_v = true
	hit_area.position.x = -40

func flip_right() -> void:
	upper.sprite.flip_v = false
	lower.sprite.flip_v = false
	hit_area.position.x = 40

func is_flipped() -> bool:
	return lower.sprite.flip_v

func get_direction() -> int:
	return -1 if is_flipped() else 1

func slash() -> void:
	pass

func shoot() -> void:
	pass

func _register_host() -> void:
	fsm.host = self

func _set_disabled(value):
	disabled = value
	fsm.set_process_unhandled_input(!value)
	set_process_input(!value)

func _set_health(value) -> void:
	health = clamp(value, 0, max_health)
	emit_signal("health_changed")
	if health == 0:
		emit_signal("died")

func _on_FiniteStateMachine_state_changed(state_name) -> void:
	emit_signal("state_changed", state_name)

func _on_Upper_AnimationPlayer_animation_finished(anim_name: String) -> void:
	var current_animation = lower.anim_player.current_animation
	upper.anim_player.play(current_animation)

func _on_Character_died() -> void:
	fsm.change_state("die")