extends State

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host = host as Character

	timer.start()

func update(host: Node, delta: float) -> void:
	host = host as Character

	if host.is_player_in_vision() and timer.is_stopped():

		if host.get_direction() == -1:
			host.flip_left()
		else:
			host.flip_right()

		host.fsm.change_state("shoot")