extends State

var left := false
var right := false

export var max_speed := 450
export var acceleration := 60
export var friction := 0.4

func enter(host: Node) -> void:
	host = host as Character
	host.play("idle")

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

	if event.is_action_pressed("jump"):
		host.fsm.change_state("jump")

	if event.is_action_pressed("ui_down"):
		host.fsm.change_state("dash")

func update(host: Node, delta: float) -> void:
	host = host as Character

	right = Input.is_action_pressed("ui_right")
	left = Input.is_action_pressed("ui_left")

	if right and not left:
		host.motion.x = clamp(host.motion.x + acceleration, 0, max_speed)
		host.flip_right()
	elif left and not right:
		host.flip_left()
		host.motion.x = clamp(host.motion.x - acceleration, -max_speed, 0)
	else:
		host.motion.x = lerp(host.motion.x, 0, friction)

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if abs(host.motion.x) < 1:
		host.fsm.change_state("idle")

	if not host.is_on_floor():
		host.fsm.change_state("fall")

func exit(host: Node) -> void:
	host = host as Character