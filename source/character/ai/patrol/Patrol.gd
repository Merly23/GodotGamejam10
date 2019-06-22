extends Character
class_name Patrol

var origin := Vector2()

export var vision := 350
export var shoot_range := 200
export var bullet_speed := 500
export var bullet_damage := 0

onready var shoot_timer := $ShootTimer as Timer

onready var barrel := $Barrel as Position2D

func _ready() -> void:
	origin = global_position
	fsm.change_state("idle")

func _register_states() -> void:
	fsm.register_state("idle", "Idle")
	fsm.register_state("walk", "Walk")
	fsm.register_state("seek", "Seek")
	fsm.register_state("attack", "Attack")

func shoot() -> void:
	var projectile = Instance.Projectile()
	projectile.shooter = self
	projectile.global_position = barrel.global_position
	get_tree().current_scene.add_child(projectile)
	projectile.fire(bullet_damage, bullet_speed, Vector2(get_player_direction(), 0))

func get_random_target_position(move_radius: float) -> Vector2:
	randomize()
	var rand = rand_range(-move_radius, move_radius)

	var new_target_position :=  Vector2(origin.x + rand, global_position.y)

	return new_target_position

func get_player_direction() -> int:

	if not Global.Player:
		return 1

	return -1 if Global.Player.global_position.x < global_position.x else 1

func can_shoot() -> bool:
	return shoot_timer.is_stopped()


func is_player_in_shoot_range() -> bool:

	if not Global.Player:
		return false

	return global_position.distance_to(Global.Player.global_position) < shoot_range

func is_player_in_vision() -> bool:

	if not Global.Player:
		return false

	return global_position.distance_to(Global.Player.global_position) < vision
