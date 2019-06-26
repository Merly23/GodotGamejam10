extends State

export var speed := 200

func enter(host: Node) -> void:
	host = host as Drone
	print("seeeeekk")

func update(host: Node, delta: float) -> void:
	host = host as Drone

	var direction = host.get_player_direction()

	if direction < 0:
		host.flip_left()
	elif direction > 0:
		host.flip_right()

	host.motion.x = direction * speed

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if not host.can_move:
		host.fsm.change_state("idle")
	elif not host.is_player_in_vision() or host.is_too_far_from_origin():
		host.fsm.change_state("retreat")
	elif host.is_player_in_shoot_range():
		host.fsm.change_state("shoot")

func exit(host: Node) -> void:
	host = host as Drone
	host.motion.y = 0