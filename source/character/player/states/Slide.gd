extends State

export var jump_force := 350

func enter(host: Node) -> void:
	host = host as Player
	host.motion.x = 0

func input(host: Node, event: InputEvent) -> void:
	host = host as Player

	if event.is_action_pressed("SPACE"):

		if not host.is_flipped():
			host.motion.x = -jump_force
		else:
			host.motion.x = jump_force

		host.flip()
		host.fsm.change_state("jump")

func update(host: Node, delta: float) -> void:
	host = host as Player

	var input_direction = host.get_input_direction()

	host.motion.y = clamp(host.motion.y + Global.GRAVITY / 4 * delta, 0, 100)

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.is_on_floor():
		host.fsm.change_state("idle")

	elif host.is_turning_on_wall():
		host.flip()
		host.fsm.change_state("fall")

	elif not host.is_on_slide_wall():
		host.fsm.change_state("fall")