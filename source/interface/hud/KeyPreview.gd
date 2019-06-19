extends Control

var key = null

onready var anim := $AnimationPlayer as AnimationPlayer

func new_key(text: String) -> void:
	key = Instance.KeyButton()
	key.text = text
	add_child(key)
	anim.play("fade_in")

func clear() -> void:
	get_child(0).queue_free()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:

	if anim_name == "fade_in":
		anim.play("press")

	if anim_name == "fade_out":
		key.queue_free()
		key = null
