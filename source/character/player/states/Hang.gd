extends State

func enter(host: Node) -> void:
	host = host as Player
	host.motion.x = 0
	host.play_lower("hang")

func input(host: Node, event: InputEvent) -> void:
	host = host as Player

	if event.is_action_pressed("jump"):
		host.cliff_timer.start()
		host.fsm.change_state("jump")

	elif event.is_action_pressed("ui_down"):
		host.cliff_timer.start()
		host.fsm.change_state("fall")

	elif host.is_turning_on_wall():
		host.cliff_timer.start()
		host.fsm.change_state("fall")