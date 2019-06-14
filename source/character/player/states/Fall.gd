extends State

func enter(host: Node) -> void:
	host = host as Character
	host.play("walk")

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character

	host.motion.y += Global.GRAVITY * delta

	if host.is_on_floor():
		if host.motion.x:
			host.fsm.change_state("walk")
		else:
			host.fsm.change_state("idle")

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

func exit(host: Node) -> void:
	host = host as Character
	host.motion.y = 0