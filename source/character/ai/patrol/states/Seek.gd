extends State

func enter(host: Node) -> void:
	host = host as Patrol

func input(host: Node, event: InputEvent) -> void:
	host = host as Patrol

func update(host: Node, delta: float) -> void:
	host = host as Patrol


	if host.is_player_in_shoot_range():
		host.fsm.change_state("shoot")
	elif not host.is_player_in_vision():
		host.fsm.change_state("idle")


func exit(host: Node) -> void:
	host = host as Patrol