extends Character

export var vision := 350
export var idle_time := 2.0
export var frequenzy := 0.2
export var max_shots := 3

onready var barrel := $Barrel as Position2D

func _ready() -> void:
	fsm.change_state("idle")
	$FiniteStateMachine/Idle/Timer.wait_time = idle_time
	$FiniteStateMachine/Shoot/Timer.wait_time = frequenzy
	$FiniteStateMachine/Shoot.max_shots = max_shots

func _register_states():
	fsm.register_state("idle", "Idle")
	fsm.register_state("shoot", "Shoot")

func flip_left() -> void:
	.flip_left()
	barrel.position.x = -55

func flip_right() -> void:
	.flip_right()
	barrel.position.x = 55

func shoot() -> void:
	var projectile = Instance.Projectile()
	projectile.shooter = self
	projectile.global_position = barrel.global_position
	get_tree().root.add_child(projectile)
	projectile.fire(is_flipped())

func is_player_in_vision() -> bool:

	if not Global.Player:
		return false

	return (global_position - Global.Player.global_position).length() < vision

func get_direction() -> int:

	if not Global.Player:
		return 1

	return -1 if Global.Player.global_position.x < global_position.x else 1