extends Character
class_name Player

signal energy_changed(energy)
signal no_energy_left()

var energy := 0 setget _set_energy

var dashing := false

export var heal_tick_time := 5.0
export var heal_tick_cooldown := 5.0

export var max_energy := 100

export var sword_damage := 2
export var recharge_modifier := 5
export var bullet_speed := 1600
export var bullet_damage := 1
export var bullet_cooldown := 0.3

export var dash_cost := 15
export var dash_cooldown := 1.0
export var slow_motion_cost := 20
export var shoot_cost := 12

export var has_virus := false

onready var slow_motion := $SlowMotion

onready var dash_timer := $DashTimer as Timer
onready var shoot_timer := $ShootTimer as Timer
onready var slow_motion_timer := $SlowMotionTimer as Timer
onready var heal_tick_timer := $HealTickTimer as Timer
onready var heal_cooldown_timer := $HealCooldownTimer as Timer

onready var capsule := collision_shape.shape as CapsuleShape2D

onready var terrain_checker := $TerrainCheckArea

onready var barrel := $ProjectileHook

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("X") and has_virus:

		if not energy - slow_motion_cost >= 0 and not slow_motion.active:
			emit_signal("no_energy_left")
			return

		if not slow_motion.toggle():
			return

		if slow_motion.active:
			_on_SlowMotionTimer_timeout()
			spawn_pulse_in()
		else:
			slow_motion_timer.stop()
			spawn_pulse_out()

func _ready() -> void:
	Global.Player = self
	fsm.change_state("fall")
	energy = max_energy
	shoot_timer.wait_time = bullet_cooldown
	dash_timer.wait_time = dash_cooldown
	heal_cooldown_timer.wait_time = heal_tick_cooldown
	heal_tick_timer.wait_time = heal_tick_time
	heal_tick_timer.start()

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("walk", "Walk")
	fsm.register_state("fall", "Fall")
	fsm.register_state("jump", "Jump")
	fsm.register_state("dash", "Dash")
	fsm.register_state("crouch", "Crouch")

func infect() -> void:
	has_virus = true

func can_dash(silent := false) -> bool:
	if not energy - dash_cost >= 0:
		if not silent:
			emit_signal("no_energy_left")
		return false
	elif not dash_timer.is_stopped():
		return false
	return true

func can_attack() -> bool:
	return not upper.anim_player.current_animation == "shoot" and not upper.anim_player.current_animation == "attack"

func can_shoot(silent := false) -> bool:
	if not energy - shoot_cost >= 0:
		if not silent:
			emit_signal("no_energy_left")
		return false
	elif not can_attack():
		return false
	return true

func can_move(can_move: bool) -> void:
	self.can_move = can_move

func flip_left() -> void:
	upper.sprite.flip_h = true
	lower.sprite.flip_h = true
	hit_area.position.x = -16

func flip_right() -> void:
	upper.sprite.flip_h = false
	lower.sprite.flip_h = false
	hit_area.position.x = 16

func attack(attack_name: String) -> void:
	play_upper(attack_name)

func play_shoot(crouch := false) -> void:
	if crouch:
		anim_player.play("crouch_shoot")
	else:
		play_upper("shoot")

func play_step():
	Audio.play_sfx("player_step")

func hurt(damage) -> void:
	if dashing:
		return

	.hurt(damage)
	heal_cooldown_timer.start()

func shoot() -> void:

	_set_energy(energy - shoot_cost)

	Audio.play_sfx("gun_shot")
	shoot_timer.start()
	var projectile = Instance.Projectile()
	projectile.shooter = self
	projectile.global_position = barrel.global_position
	get_tree().current_scene.add_child(projectile)
	projectile.fire(bullet_damage, bullet_speed, Vector2(get_shoot_direction(), 0))

func slash() -> void:

	var bodies = hit_area.get_overlapping_bodies()

	Audio.play_sfx("player_slash")

	for body in bodies:
		if body is Character and body.team_number != team_number:
			body.hurt(sword_damage)
			_set_energy(energy + sword_damage * recharge_modifier)

func crouch() -> void:
	collision_shape.position.y = -16
	barrel.position.y = -23
	capsule.height = 10

func stand() -> void:
	barrel.position.y = -31
	collision_shape.position.y = -24
	capsule.height = 26

func get_input_direction(normalized := true) -> Vector2:

	var direction := Vector2()

	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")

	if left and not right:
		direction.x = -1
	elif right and not left:
		direction.x = 1

	if up and not down:
		direction.y = -1
	elif down and not up:
		direction.y = 1

	if not direction:
		direction.x = -1 if is_flipped() else 1

	return direction.normalized() if normalized else direction

func get_shoot_direction() -> int:
	return -1 if is_flipped() else 1

func cancel_slow_motion() -> void:
	if slow_motion.active:
		slow_motion.toggle()
		spawn_pulse_out()

func spawn_after_image() -> void:
	var center = Vector2(global_position.x, global_position.y - 32)
	particle_spawner.spawn_after_image(center, is_flipped())

func spawn_pulse_in() -> void:
	var center = Vector2(0, -32)
	Audio.play_sfx("player_slow_motion_start")
	particle_spawner.spawn_pulse_in(center)

func spawn_pulse_out() -> void:
	var center = Vector2(0, -32)
	Audio.play_sfx("player_slow_motion_end")
	particle_spawner.spawn_pulse_out(center)

func set_glitch_level(level: int) -> void:
	Glitch.level = level

func _set_energy(value) -> void:
	energy = clamp(value, 0, max_energy)
	emit_signal("energy_changed", energy)

func is_energy_filled() -> bool:
	return energy == max_energy

func is_attacking() -> bool:
	return upper.anim_player.current_animation == "attack" or upper.anim_player.current_animation == "air_attack"

func _on_Upper_AnimationPlayer_animation_finished(anim_name: String) -> void:
	var current_animation = lower.anim_player.current_animation

	if anim_name == "attack" or anim_name == "shoot":
		upper.anim_player.play(current_animation)
		upper.anim_player.advance(lower.anim_player.current_animation_position)

func _on_SlowMotionTimer_timeout() -> void:
	if energy - slow_motion_cost >= 0:
		_set_energy(energy - slow_motion_cost)
		Audio.play_sfx("tick")
		slow_motion_timer.start(slow_motion.time_scale)
	else:
		cancel_slow_motion()
		emit_signal("no_energy_left")
		print("slomo tick")

func _on_Tick_timeout() -> void:
	if not slow_motion.active and not is_energy_filled():
		_set_energy(energy + 5)

func _on_HitArea_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name == "Projectile" and is_attacking():
		area.queue_free()

func _on_HealTickTimer_timeout() -> void:

	if not heal_cooldown_timer.is_stopped():
		return

	if health == max_health:
		return
	_set_health(health + 1)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "crouch_shoot":
		anim_player.play("crouch")
