extends State

export var max_speed := 450
export var acceleration := 20
export var friction := 0.4

export var fall_damage_threshold := 1500

onready var timer := $Timer as Timer

func enter(host: Node) -> void:
	host.motion.y = 0
	host = host as Player
	host.play("fall")

func input(host: Node, event: InputEvent) -> void:
	host = host as Player

	if event.is_action_pressed("B"):
		host.attack("air_attack")

	if event.is_action_pressed("C") and host.can_dash() and host.has_virus:
		host.fsm.change_state("dash")

	if event.is_action_pressed("SPACE"):
		timer.start()

func update(host: Node, delta: float) -> void:
	host = host as Player

	var left = Input.is_action_pressed("ui_left") if not host.disabled else false
	var right = Input.is_action_pressed("ui_right") if not host.disabled else false

	if host.is_on_wall():
		host.motion.x = 0

	host.motion.y += Global.GRAVITY * delta

	if left and not right:
		host.motion.x = clamp(host.motion.x - acceleration, -max_speed, max_speed)
		host.flip_left()
	elif right and not left:
		host.motion.x = clamp(host.motion.x + acceleration, -max_speed, max_speed)
		host.flip_right()
	else:
		host.motion.x = lerp(host.motion.x, 0, friction)
		if abs(host.motion.x) < 0.1:
			host.motion.x = 0

	if host.is_on_floor():

		Audio.play_sfx("player_land")

		var fall_damage = int(host.motion.y / fall_damage_threshold)

		if fall_damage:
			host.hurt(fall_damage)

		if not timer.is_stopped() and not host.dead and host.can_move:
			host.fsm.change_state("jump")
		elif host.motion.x and not host.dead and host.can_move:
			host.fsm.change_state("walk")
		elif not host.dead:
			host.fsm.change_state("idle")

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

	if Input.is_action_pressed("V") and host.can_shoot() and not host.disabled:
		host.play_shoot()

func exit(host: Node) -> void:
	host.spawn_land_dust()
	host = host as Character
	host.motion.y = 0