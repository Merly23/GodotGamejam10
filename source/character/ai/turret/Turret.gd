extends Character
class_name Turret

export var vision := 350
export var idle_time := 5.0
export var frequenzy := 1.0
export var max_shots := 2
export var bullet_speed := 800
export var bullet_damage := 1

onready var barrel := $Barrel

func _ready() -> void:
	fsm.change_state("idle")
	$FiniteStateMachine/Idle/Timer.wait_time = idle_time

func _register_states():
	fsm.register_state("idle", "Idle")

func flip_left() -> void:
	.flip_left()
	barrel.position.x = -14

func flip_right() -> void:
	.flip_right()
	barrel.position.x = 14

func shoot() -> void:
	var projectile = Instance.Projectile()
	projectile.shooter = self
	projectile.global_position = barrel.global_position
	get_tree().current_scene.add_child(projectile)
	projectile.fire(bullet_damage, bullet_speed, Vector2(1 if is_flipped() else -1, 0))

func is_player_in_vision() -> bool:

	if not Global.Player:
		return false

	return global_position.distance_to(Global.Player.global_position) < vision