extends State

func enter(host: Node) -> void:
	host = host as Character
	# host.anim.play("idle")

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

	var left = event.is_action_pressed("ui_left")
	var right = event.is_action_pressed("ui_right")

	if bool(int(left) + int(right)):
		host.fsm.change_state("walk")

func update(host: Node, delta: float) -> void:
	host = host as Character

func exit(host: Node) -> void:
	host = host as Character