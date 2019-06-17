extends Node

var active := false
var time_scale := 1.0

onready var tween := $Tween as Tween

func toggle() -> void:

	if tween.is_active():
		return

	if active:
		tween.interpolate_property(self, "time_scale", Engine.time_scale, 1.0, 0.3, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween.start()
		active = false
	else:
		tween.interpolate_property(self, "time_scale", Engine.time_scale, 0.5, 0.3, Tween.TRANS_SINE, Tween.EASE_OUT)
		tween.start()
		active = true

func _on_Tween_tween_step(object: Object, key: NodePath, elapsed: float, value) -> void:
	Engine.time_scale = value
