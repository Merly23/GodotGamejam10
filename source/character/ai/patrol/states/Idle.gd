extends State

onready var idle_timer := $IdleTimer as Timer

func enter(host: Node) -> void:
	host = host as Patrol
	idle_timer.start()
	if not idle_timer.is_connected("timeout", self, "_on_IdleTimer_timeout"):
		idle_timer.connect("timeout", self, "_on_IdleTimer_timeout", [ host ])

func input(host: Node, event: InputEvent) -> void:
	host = host as Patrol

func update(host: Node, delta: float) -> void:
	host = host as Patrol

	if host.is_player_in_shoot_range():
		host.fsm.change_state("shoot")
	if host.is_player_in_vision():
		host.fsm.change_state("seek")

func exit(host: Node) -> void:
	host = host as Patrol

func _on_IdleTimer_timeout(host: Patrol) -> void:
	host.fsm.change_state("walk")