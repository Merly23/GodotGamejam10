extends Turret
class_name Drone

export var seek_distance := 500

onready var origin := global_position

func _ready() -> void:
	lower.sprite.region_rect.position.y = 64 * (randi() % 3)

onready var rays := {
	left = $Rays/Left,
	right = $Rays/Right,
	up = $Rays/Up,
	down = $Rays/Down
}

func _register_states():
	fsm.register_state("idle", "Idle")
	fsm.register_state("shoot", "Shoot")
	fsm.register_state("seek", "Seek")

func terrain_on(direction: String) -> bool:

	if not rays[direction].is_colliding():
		return false

	var collider = rays[direction].get_collider()

	print(collider)

	return collider == Global.Terrain

func is_too_far_from_origin() -> bool:
	return global_position.distance_to(origin) > seek_distance
