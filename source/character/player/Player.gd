extends Character

export var sword_damage := 2
export var bullet_speed := 1600
export var bullet_damage := 1

onready var slow_motion := $SlowMotion

onready var dash_timer := $DashTimer as Timer

onready var terrain_checker := $TerrainCheckArea

onready var barrel := $ProjectileHook

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("X"):
		slow_motion.toggle()
		spawn_pulse_in()

	if event.is_action_pressed("V"):
		shoot()

func _ready() -> void:
	Global.Player = self
	fsm.change_state("idle")

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("walk", "Walk")
	fsm.register_state("fall", "Fall")
	fsm.register_state("jump", "Jump")
	fsm.register_state("dash", "Dash")

func flip_left() -> void:
	.flip_left()
	barrel.position.x = -40

func flip_right() -> void:
	.flip_right()
	barrel.position.x = 40

func can_dash() -> bool:
	return dash_timer.is_stopped()

func attack() -> void:
	play_upper("attack")

func shoot() -> void:
	var projectile = Instance.Projectile()
	projectile.shooter = self
	projectile.global_position = barrel.global_position
	get_tree().root.add_child(projectile)
	projectile.fire(bullet_speed, bullet_damage, is_flipped())

func slash() -> void:

	print("slash")

	var bodies = hit_area.get_overlapping_bodies()

	for body in bodies:
		print(body.name)
		if body is Character and body.team_number != team_number:
			body.hurt(sword_damage)

func spawn_after_image() -> void:
	var center = Vector2(global_position.x, global_position.y - 32)
	particle_spawner.spawn_after_image(center, is_flipped())

func spawn_pulse_in() -> void:
	var center = Vector2(global_position.x, global_position.y - 32)
	particle_spawner.spawn_pulse_in(center)