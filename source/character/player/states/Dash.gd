extends State

export var force := Vector2(1200, -60)
export var friction := 0.05

func enter(host: Node) -> void:
	host = host as Character
	host.play("dash")
	if host.is_flipped():
		host.motion = Vector2(-force.x, force.y)
	else:
		host.motion = force

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character

	host.motion.y += Global.GRAVITY * delta
	host.motion.x = lerp(host.motion.x, 0, friction)
	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.is_on_floor():
		if abs(host.motion.x) < 500:
			host.fsm.change_state("walk")

func exit(host: Node) -> void:
	host = host as Character