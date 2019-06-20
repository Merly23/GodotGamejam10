extends State

func enter(host) -> void:
	host = host as Character
	host.stop_anim()
	host.anim_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished", [ host ])
	host.anim_player.queue("die")
	host.spawn_sparks()

func update(host: Node, delta: float) -> void:
	host = host as Character

	host.motion.x = lerp(host.motion.x, 0, 0.05)
	print(host.motion.x)
	host.motion.y += Global.GRAVITY * delta

	host.move_and_slide_with_snap(host.motion, Global.DOWN, Global.UP)

func _on_AnimationPlayer_animation_finished(anim_name: String, host: Character) -> void:
	host.queue_free()