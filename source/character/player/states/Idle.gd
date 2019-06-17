extends State

func enter(host: Node) -> void:
	host = host as Character
	host.play("idle")
	host.motion = Vector2(0,0)

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

	if event.is_action_pressed("SPACE"):
		host.fsm.change_state("jump")

	if event.is_action_pressed("ui_down"):
		host.fsm.change_state("dash")

func update(host: Node, delta: float) -> void:
	host = host as Character

	var left = Input.is_action_pressed("ui_left") if not host.disabled else false
	var right = Input.is_action_pressed("ui_right") if not host.disabled else false

	if not host.is_on_floor():
		host.fsm.change_state("fall")

	elif bool(int(left) + int(right)):
		host.fsm.change_state("walk")

func exit(host: Node) -> void:
	host = host as Character