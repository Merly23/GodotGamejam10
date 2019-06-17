extends Character

onready var slow_motion := $SlowMotion

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("X"):
		slow_motion.toggle()
		spawn_pulse_in()

	if event.is_action_pressed("C"):
		shoot()

func _ready() -> void:
	Global.Player = self
	fsm.change_state("idle")
	hooks["pulse"] = $Hooks/Pulse
	hooks["barrel"] = $Hooks/Barrel

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("walk", "Walk")
	fsm.register_state("fall", "Fall")
	fsm.register_state("jump", "Jump")
	fsm.register_state("dash", "Dash")

func flip_left() -> void:
	.flip_left()
	hooks.barrel.position.x = -44

func flip_right() -> void:
	.flip_right()
	hooks.barrel.position.x = 44

func shoot() -> void:
	var projectile = Instance.Projectile()
	projectile.global_position = hooks.barrel.global_position
	get_tree().root.add_child(projectile)
	projectile.fire(is_flipped())

func spawn_pulse_in() -> void:
	var pulse = Instance.Pulse()
	pulse.global_position = hooks.pulse.global_position
	get_tree().root.add_child(pulse)
	pulse.play("in")
