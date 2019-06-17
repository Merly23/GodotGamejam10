extends State

export var force := 1400
export var friction := 4500

var direction := Vector2()

func enter(host: Node) -> void:
	host = host as Character
	host.disable_collision()
	host.play("dash")
	host.spawn_dash_dust()
	direction = get_direction()
	host.motion = Vector2(force, force) * direction

func input(host: Node, event: InputEvent) -> void:
	host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character

	# host.motion.y += Global.GRAVITY * delta

	host.motion -= Vector2(friction, friction) * direction * delta
	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if host.motion.length() < 500:
		if host.terrain_checker.is_in_terrain():
			host.fsm.change_state("die")
		else:
			host.fsm.change_state("fall")

func exit(host: Node) -> void:
	host = host as Character
	host.enable_collision()

func get_direction() -> Vector2:
	var direction := Vector2()

	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")

	if left and not right:
		direction.x = -1
	elif right and not left:
		direction.x = 1

	if up and not down:
		direction.y = -1
	elif down and not up:
		direction.y = 1


	return direction.normalized()
