extends State

export var speed = 120

func enter(host: Node) -> void:
	host = host as Patrol

func input(host: Node, event: InputEvent) -> void:
	host = host as Patrol

func update(host: Node, delta: float) -> void:
	host = host as Patrol

	if host.is_on_floor():
		host.motion.y = 0
	else:
		host.motion.y += Global.GRAVITY * delta

	host.motion.x = host.get_player_direction() * speed

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.is_player_in_shoot_range():
		host.fsm.change_state("shoot")
	elif not host.is_player_in_vision() or host.is_on_wall():
		host.fsm.change_state("idle")

func exit(host: Node) -> void:
	host = host as Patrol