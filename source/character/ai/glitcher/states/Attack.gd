extends State

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host = host as Glitcher
	timer.start()

func input(host: Node, event: InputEvent) -> void:
	host = host as Glitcher

func update(host: Node, delta: float) -> void:
	host = host as Glitcher

	var direction = host.get_player_direction()

	if host.is_player_in_attack_range() and timer.is_stopped():
		if direction < 0:
			host.flip_left()
		elif direction > 0:
			host.flip_right()
		host.attack()
		host.play_lower("attack")
		timer.start()

	elif not host.can_move:
		host.fsm.change_state("idle")
	elif not host.is_player_in_attack_range():
		host.fsm.change_state("seek")

func exit(host: Node) -> void:
	host = host as Glitcher