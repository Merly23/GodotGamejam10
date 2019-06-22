extends State

var left := false
var right := false

export var max_speed := 450
export var acceleration := 60
export var friction := 0.4

var stopped := false

func enter(host: Node) -> void:
	host = host as Character
	host.play("walk")

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

	if event.is_action_pressed("SPACE"):
		host.fsm.change_state("jump")

	if event.is_action_pressed("B"):
		host.attack("attack")

	if event.is_action_pressed("C") and host.can_dash() and host.has_virus:
		host.fsm.change_state("dash")


func update(host: Node, delta: float) -> void:
	host = host as Character

	right = Input.is_action_pressed("ui_right") if not host.disabled else false
	left = Input.is_action_pressed("ui_left") if not host.disabled else false

	if right and not left:
		host.motion.x = clamp(host.motion.x + acceleration, 0, max_speed)
		host.flip_right()
		stopped = false
	elif left and not right:
		host.motion.x = clamp(host.motion.x - acceleration, -max_speed, 0)
		host.flip_left()
		stopped = false
	else:
		host.motion.x = lerp(host.motion.x, 0, friction)
		if not stopped:
			host.spawn_stop_dust()
			Audio.play_sfx("player_stop")
			stopped = true

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if abs(host.motion.x) < 1:
		host.fsm.change_state("idle")

	elif not host.is_on_floor():
		host.fsm.change_state("fall")

	elif Input.is_action_pressed("V") and host.can_shoot() and not host.disabled:
		host.play_shoot()

	elif Input.is_action_pressed("ui_down"):
		host.fsm.change_state("crouch")
		host.spawn_stop_dust()

func exit(host: Node) -> void:
	stopped = true
	host = host as Character