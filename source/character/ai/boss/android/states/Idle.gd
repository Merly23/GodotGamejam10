extends State

onready var idle_timer := $IdleTimer as Timer

func enter(host: Node) -> void:
	host = host as Android

func input(host: Node, event: InputEvent) -> void:
	host = host as Android

func update(host: Node, delta: float) -> void:
	host = host as Android

func exit(host: Node) -> void:
	host = host as Android
