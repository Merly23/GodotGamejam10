extends State

func enter(host) -> void:
	host = host as Drone
	host.stop_anim()
	host.audio_player.stop()
	host.anim_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished", [ host ])
	host.anim_player.queue("die")

func update(host: Node, delta: float) -> void:
	host = host as Drone

	host.motion.x = lerp(host.motion.x, 0, 0.05)

	if not host.is_on_floor():
		host.motion.y += Global.GRAVITY * delta
	else:
		host.motion.y = 0

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

func _on_AnimationPlayer_animation_finished(anim_name: String, host: Drone) -> void:
	host.queue_free()