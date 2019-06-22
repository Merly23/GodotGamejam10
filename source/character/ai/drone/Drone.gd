extends Turret
class_name Drone

export var seek_distance := 500
export var sound_distance := 2000

onready var audio_player := $AudioStreamPlayer as AudioStreamPlayer

onready var origin := global_position

func _ready() -> void:
	lower.sprite.region_rect.position.y = 64 * (randi() % 3)

func _process(delta: float) -> void:
	if Global.Player:
		var volume = 0.5 - (Global.Player.global_position.distance_to(global_position) / sound_distance)
		audio_player.volume_db = linear2db(clamp(volume, 0, 0.6))

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
	fsm.register_state("retreat", "Retreat")

func flip_left() -> void:
	.flip_left()
	barrel.position.x = 0

func flip_right() -> void:
	.flip_right()
	barrel.position.x = 0

func spawn_sparks():
	.spawn_sparks()

func is_player_in_shoot_range() -> bool:

	if not Global.Player:
		return false
	var distance_vector = Global.Player.global_position - global_position
	distance_vector.x /= 20
	return distance_vector.length() < 20

func get_origin_direction() -> Vector2:
	return (origin - global_position).normalized()

func get_player_vector_direction() -> Vector2:
	if not Global.Player:
		return Vector2()

	return (Global.Player.global_position - global_position).normalized()

func terrain_on(direction: String) -> bool:

	if not rays[direction].is_colliding():
		return false

	var collider = rays[direction].get_collider()

	print(collider)

	return collider == Global.Terrain

func is_too_far_from_origin() -> bool:
	return global_position.distance_to(origin) > seek_distance
