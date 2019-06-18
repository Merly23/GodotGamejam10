extends KinematicBody2D
class_name Character

signal state_changed(state_name)

signal health_changed(health)

signal hurt(damage)

signal died

var motion := Vector2()

var health setget _set_health

var bottom_limit := 99999

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

onready var particle_spawner := $ParticleSpawner as ParticleSpawner

onready var collision_shape := $CollisionShape2D as CollisionShape2D

onready var hit_area := $HitArea as Area2D

onready var fsm := $FiniteStateMachine as FiniteStateMachine

func _ready() -> void:
	_register_host()
	_register_states()
	fsm.register_state("die", "Die")
	health = max_health
	move_and_slide_with_snap(Vector2(0,0), Global.DOWN, Global.UP)

func _process(delta: float) -> void:
	if global_position.y > bottom_limit:
		get_tree().reload_current_scene()

func _register_states() -> void:
	print("Character::_ready->_setup_states: Overwrite!")

func hurt(damage) -> void:
	_set_health(health - damage)
	anim_player.play("hurt")
	emit_signal("hurt", damage)

func play(anim_name: String) -> void:

	if not upper.anim_player.current_animation == "attack":
		upper.anim_player.play(anim_name)
	lower.anim_player.play(anim_name)

func play_upper(anim_name: String) -> void:
#	upper.anim.travel(anim_name)
	upper.anim_player.play(anim_name)

func play_lower(anim_name: String) -> void:
#	lower.anim.travel(anim_name)
	lower.anim_player.play(anim_name)

func spawn_jump_dust() -> void:
	particle_spawner.spawn_jump_dust(global_position)

func spawn_dash_dust() -> void:
	particle_spawner.spawn_dash_dust(global_position, is_flipped())

func spawn_stop_dust() -> void:
	particle_spawner.spawn_stop_dust(global_position, 31, is_flipped())

func spawn_land_dust() -> void:
	particle_spawner.spawn_land_dust(global_position, 31, is_flipped())

func enable_collision() -> void:
	collision_shape.disabled = false

func disable_collision() -> void:
	collision_shape.disabled = true

func flip() -> void:
	if is_flipped():
		flip_right()
	else:
		flip_left()

func flip_left() -> void:
	upper.sprite.flip_h = true
	lower.sprite.flip_h = true
	hit_area.position.x = -40

func flip_right() -> void:
	upper.sprite.flip_h = false
	lower.sprite.flip_h = false
	hit_area.position.x = 40

func is_flipped() -> bool:
	return lower.sprite.flip_h

func get_direction() -> int:
	return -1 if is_flipped() else 1

func slash() -> void:
	pass

func shoot() -> void:
	pass

func set_bottom_limit(value) -> void:
	bottom_limit = value

func get_current_frame() -> int:
	return lower.sprite.frame

func reset_modulate() -> void:
	upper.sprite.modulate = Color("FFFFFFFF")
	lower.sprite.modulate = Color("FFFFFFFF")

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
	print("animation finished")
	var current_animation = lower.anim_player.current_animation

	if anim_name != "attack":
		return

	upper.anim_player.play(current_animation)
	upper.anim_player.advance(lower.anim_player.current_animation_position)

func _on_Character_died() -> void:
	fsm.change_state("die")