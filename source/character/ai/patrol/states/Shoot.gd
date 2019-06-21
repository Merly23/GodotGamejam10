extends State

var shots := 0

export var max_shots := 3

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host = host as Patrol

func input(host: Node, event: InputEvent) -> void:
	host = host as Patrol

func update(host: Node, delta: float) -> void:
	host = host as Patrol

	if shots < max_shots:

		if timer.is_stopped():
			timer.start()
			shots += 1
			host.shoot()
	else:
		host.fsm.change_state("walk")

func exit(host: Node) -> void:
	host = host as Patrol
	host.shoot_timer.start()
	shots = 0