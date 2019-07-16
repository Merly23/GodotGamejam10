extends State

func enter(host: Node) -> void:
	host = host as Player
	host.motion.x = 0
	host.stop_anim()
	host.anim_player.play("hang")

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

func exit(host: Node) -> void:
	host = host as Player
	host.anim_player.play("reset")
	host.reset_modulate()
