extends State

func enter(host: Node) -> void:
	host = host as Player
	host.stop_anim()
	host.anim_player.play("crouch")
	host.crouch()

func update(host: Node, delta: float) -> void:
	host = host as Player

	var left = Input.is_action_pressed("ui_left") if not host.disabled else false
	var right = Input.is_action_pressed("ui_right") if not host.disabled else false

	if not host.is_on_floor():
		host.fsm.change_state("fall")
	elif not Input.is_action_pressed("ui_down"):
		host.fsm.change_state("idle")
	elif Input.is_action_pressed("V") and host.can_shoot() and not host.disabled:
		host.play_shoot(true)

func exit(host: Node) -> void:
	host = host as Player
	host.anim_player.stop()
	host.stand()
	host.reset_modulate()