extends State

var direction := 1

export var max_speed := 160
export var acceleration := 8

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host = host as Drone
	host.play_lower("idle")
	timer.start()

func update(host: Node, delta: float) -> void:
	host = host as Drone

	if direction == 1 and host.terrain_on("right"):
		direction = -1
	elif direction == -1 and host.terrain_on("left"):
		direction = 1

	if direction == -1:
		host.motion.x = clamp(host.motion.x - acceleration, -max_speed, max_speed)
		host.flip_left()
	else:
		host.motion.x = clamp(host.motion.x + acceleration, -max_speed, max_speed)
		host.flip_right()

	host.move_and_slide(host.motion, Global.UP)

	if host.is_player_in_vision() and timer.is_stopped():
		pass # host.fsm.change_state("seek")