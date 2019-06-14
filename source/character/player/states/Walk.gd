extends State

var left := false
var right := false

export var max_speed := 300
export var acceleration := 20
export var friction := 50

func enter(host: Node) -> void:
	host = host as Character
	# host.anim.play("walk")

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character

	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")

	if not bool(int(left) + int(right)):
		host.fsm.change_state("idle")

func exit(host: Node) -> void:
	host = host as Character
