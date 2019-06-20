extends Character
class_name Player

signal energy_changed(energy)
signal no_energy_left()

var energy := 0 setget _set_energy

export var max_energy := 100

export var sword_damage := 2
export var recharge_modifier := 5
export var bullet_speed := 1600
export var bullet_damage := 1
export var bullet_cooldown := 0.3

export var dash_cost := 10
export var slow_motion_cost := 10
export var shoot_cost := 5

onready var slow_motion := $SlowMotion

onready var dash_timer := $DashTimer as Timer
onready var shoot_timer := $ShootTimer as Timer
onready var slow_motion_timer := $SlowMotionTimer as Timer

onready var terrain_checker := $TerrainCheckArea

onready var barrel := $ProjectileHook

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("X"):

		if not energy - slow_motion_cost >= 0 and not slow_motion.active:
			emit_signal("no_energy_left")
			return

		slow_motion.toggle()
		if slow_motion.active:
			_on_SlowMotionTimer_timeout()
		else:
			slow_motion_timer.stop()
		spawn_pulse_in()

func _ready() -> void:
	Global.Player = self
	fsm.change_state("idle")
	energy = max_energy
	shoot_timer.wait_time = bullet_cooldown

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("walk", "Walk")
	fsm.register_state("fall", "Fall")
	fsm.register_state("jump", "Jump")
	fsm.register_state("dash", "Dash")

func can_dash() -> bool:
	return dash_timer.is_stopped()

func can_shoot() -> bool:
	return shoot_timer.is_stopped()

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

func shoot() -> void:

	if not energy - shoot_cost >= 0:
		emit_signal("no_energy_left")
		return

	_set_energy(energy - shoot_cost)

	Audio.play_sfx("gun_shot")
	shoot_timer.start()
	var projectile = Instance.Projectile()
	projectile.shooter = self
	projectile.global_position = barrel.global_position
	get_tree().root.add_child(projectile)
	projectile.fire(bullet_damage, bullet_speed, Vector2(get_shoot_direction(), 0))

func slash() -> void:

	var bodies = hit_area.get_overlapping_bodies()
	Audio.play_sfx("player_slash")

	for body in bodies:
		if body is Character and body.team_number != team_number:
			body.hurt(sword_damage)
			_set_energy(energy + sword_damage * recharge_modifier)

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

func spawn_after_image() -> void:
	var center = Vector2(global_position.x, global_position.y - 32)
	particle_spawner.spawn_after_image(center, is_flipped())

func spawn_pulse_in() -> void:
	var center = Vector2(global_position.x, global_position.y - 32)
	particle_spawner.spawn_pulse_in(center)

func _set_energy(value) -> void:
	energy = clamp(value, 0, max_energy)
	emit_signal("energy_changed", energy)

func _on_SlowMotionTimer_timeout() -> void:
	if energy - slow_motion_cost >= 0:
		_set_energy(energy - slow_motion_cost)
		Audio.play_sfx("tick")
		slow_motion_timer.start(slow_motion.time_scale)
	else:
		slow_motion.toggle()
		slow_motion_timer.stop()
		spawn_pulse_in()
		emit_signal("no_energy_left")