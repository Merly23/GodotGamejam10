extends State

func enter(host: Node) -> void:
	host = host as Character
	host.play("idle")
	host.motion = Vector2(0,0)

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character

	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")

func exit(host: Node) -> void:
	host = host as Character