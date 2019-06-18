extends State

export var max_speed := 450
export var acceleration := 20
export var friction := 0.4

func enter(host: Node) -> void:
	host.motion.y = 0
	host = host as Character
	host.play("fall")

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

	if event.is_action_pressed("C") and host.can_dash():
		host.fsm.change_state("dash")

func update(host: Node, delta: float) -> void:
	host = host as Character

	var left = Input.is_action_pressed("ui_left") if not host.disabled else false
	var right = Input.is_action_pressed("ui_right") if not host.disabled else false

	if host.is_on_wall():
		host.motion.x = 0

	host.motion.y += Global.GRAVITY * delta

	if left and not right:
		host.motion.x = clamp(host.motion.x - acceleration, -max_speed, max_speed)
		host.flip_left()
	elif right and not left:
		host.motion.x = clamp(host.motion.x + acceleration, -max_speed, max_speed)
		host.flip_right()
	else:
		host.motion.x = lerp(host.motion.x, 0, friction)
		if abs(host.motion.x) < 0.1:
			host.motion.x = 0

	if host.is_on_floor():
		if host.motion.x:
			host.fsm.change_state("walk")
		else:
			host.fsm.change_state("idle")
		host.spawn_land_dust()

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

func exit(host: Node) -> void:
	host = host as Character
	host.motion.y = 0