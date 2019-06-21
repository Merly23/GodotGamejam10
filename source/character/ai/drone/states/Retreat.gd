extends State

export var speed := 150
export var home_distance := 50

func enter(host: Node) -> void:
	host = host as Drone
	print("retreeeat")

func update(host: Node, delta: float) -> void:
	host = host as Drone

	var direction = host.get_origin_direction()

	host.motion = direction * speed

	if direction.x < 0:
		host.flip_left()
	elif direction.x > 0:
		host.flip_right()

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.global_position.distance_to(host.origin) < home_distance:
		host.fsm.change_state("idle")

func exit(host: Node) -> void:
	host = host as Drone
	host.motion.y = 0