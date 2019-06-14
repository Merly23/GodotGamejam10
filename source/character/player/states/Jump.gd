extends State

export var jump_force := 450

func enter(host: Node) -> void:
	host = host as Character
	host.play("jump")
	host.motion.y = -jump_force

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character

	host.motion.y += Global.GRAVITY * delta

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.motion.y >= 0 or host.is_on_ceiling():
		host.fsm.change_state("fall")

	if host.is_on_floor():
		host.fsm.change_state("idle")

func exit(host: Node) -> void:
	host = host as Character