extends State

var shots := 0

export var max_shots := 5

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character

	if shots < max_shots:

		if timer.is_stopped():
			timer.start()
			shots += 1
			host.shoot()

	elif not host.can_move:
		host.fsm.change_state("idle")
	else:
		host.fsm.change_state("idle")

func exit(host: Node) -> void:
	host = host as Character
	shots = 0