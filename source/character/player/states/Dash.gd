extends State

export var force := Vector2(1400, 0)
export var friction := 4500

func enter(host: Node) -> void:
	host = host as Character
	host.play("dash")
	host.spawn_dash_dust()
	if host.is_flipped():
		host.motion = Vector2(-force.x, force.y)
	else:
		host.motion = force

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character

	# host.motion.y += Global.GRAVITY * delta
	var direction = -1 if host.is_flipped() else 1

	host.motion.x -= friction * direction * delta
	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if abs(host.motion.x) < 500:
		host.fsm.change_state("fall")

func exit(host: Node) -> void:
	host = host as Character