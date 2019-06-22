extends State

var shots := 0

export var max_shots := 3

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host = host as Glitcher

func input(host: Node, event: InputEvent) -> void:
	host = host as Glitcher

func update(host: Node, delta: float) -> void:
	host = host as Glitcher

	if host.is_player_in_attack_range() and timer.is_stopped():
		host.attack()
		timer.start()
	elif not host.is_player_in_attack_range():
		host.fsm.change_state("seek")

func exit(host: Node) -> void:
	host = host as Glitcher