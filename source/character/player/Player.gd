extends Character
class_name Player

export var sword_damage := 2
export var bullet_speed := 1600
export var bullet_damage := 1
export var bullet_cooldown := 0.3

onready var slow_motion := $SlowMotion

onready var dash_timer := $DashTimer as Timer
onready var shoot_timer := $ShootTimer as Timer

onready var terrain_checker := $TerrainCheckArea

onready var barrel := $ProjectileHook

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("X"):
		slow_motion.toggle()
		spawn_pulse_in()

func _ready() -> void:
	Global.Player = self
	fsm.change_state("idle")
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

func attack(attack_name: String) -> void:
	play_upper(attack_name)

func shoot() -> void:
	shoot_timer.start()
	var projectile = Instance.Projectile()
	projectile.shooter = self
	projectile.global_position = barrel.global_position
	get_tree().root.add_child(projectile)
	projectile.fire(bullet_damage, bullet_speed, get_input_direction(false))

func slash() -> void:

	print("slash")

	var bodies = hit_area.get_overlapping_bodies()

	for body in bodies:
		print(body.name)
		if body is Character and body.team_number != team_number:
			body.hurt(sword_damage)

func get_input_direction(normalized := true) -> Vector2:

	var direction := Vector2()

	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")

# directional shooting
#	if left and not right:
#		direction.x = -1
#	elif right and not left:
#		direction.x = 1
#
#	if up and not down:
#		direction.y = -1
#	elif down and not up:
#		direction.y = 1
#
#	if not direction:
#		direction.x = -1 if is_flipped() else 1

	direction.x = -1 if is_flipped() else 1

	return direction.normalized() if normalized else direction

func spawn_after_image() -> void:
	var center = Vector2(global_position.x, global_position.y - 32)
	particle_spawner.spawn_after_image(center, is_flipped())

func spawn_pulse_in() -> void:
	var center = Vector2(global_position.x, global_position.y - 32)
	particle_spawner.spawn_pulse_in(center)