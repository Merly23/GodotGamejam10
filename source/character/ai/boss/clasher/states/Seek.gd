extends State

export var speed = 200

func enter(host: Node) -> void:
	host = host as Clasher
	host.anim_player.play("walk")

func input(host: Node, event: InputEvent) -> void:
	host = host as Clasher

func update(host: Node, delta: float) -> void:
	host = host as Clasher

	var direction = host.get_player_direction()

	if direction == 1:
		host.motion.x = speed
		host.flip_right()
	elif direction == -1:
		host.motion.x = -speed
		host.flip_left()
	else:
		host.fsm.change_state("idle")
	
	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)
	# host.fsm.change_state("dash_attack")
	
	if host.is_player_in_attack_range():
		host.fsm.change_state("idle")
	
func exit(host: Node) -> void:
	host = host as Clasher