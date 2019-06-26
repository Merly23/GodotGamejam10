extends State

var direction := 1

export var max_speed := 160
export var acceleration := 8

onready var timer := $Timer as Timer
onready var flip_timer := $FlipTimer as Timer

func enter(host: Node) -> void:
	host = host as Drone
	host.play_lower("hover")
	timer.start()

func update(host: Node, delta: float) -> void:
	host = host as Drone

	if direction == 1 and host.terrain_on("right") and not host.disabled:
		direction = -1
	elif direction == -1 and host.terrain_on("left") and not host.disabled:
		direction = 1

	if host.is_too_far_from_origin() and flip_timer.is_stopped():
		direction *= -1
		flip_timer.start()

	if direction == -1:
		host.motion.x = clamp(host.motion.x - acceleration, -max_speed, max_speed)
		host.flip_left()
	else:
		host.motion.x = clamp(host.motion.x + acceleration, -max_speed, max_speed)
		host.flip_right()

	host.move_and_slide(host.motion, Global.UP)

	if host.is_player_in_shoot_range() and timer.is_stopped() and not host.disabled and host.can_move:
		host.shoot()
		timer.start()
