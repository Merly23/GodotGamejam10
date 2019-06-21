extends State

var shots := 0

export var max_shots := 5

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host = host as Drone
	print("shooot")

func update(host: Node, delta: float) -> void:
	host = host as Drone

	if shots < max_shots:

		if timer.is_stopped():
			timer.start()
			shots += 1
			host.shoot()
	else:
		host.fsm.change_state("seek")

func exit(host: Node) -> void:
	host = host as Drone
	shots = 0