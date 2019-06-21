extends Camera2D
class_name GameCam

var _target = null
var _prev_target = null

var prev_position := Vector2()

onready var timer := $Timer as Timer
onready var screen_shake := $ScreenShake as ScreenShake

func _process(delta: float) -> void:
	if _target:
		var direction = _target.global_position.x - prev_position.x
		if direction > 5:
			global_position = _target.global_position + Vector2(120, 0)
		elif direction < -5:
			global_position = _target.global_position + Vector2(-120, 0)
		prev_position = _target.global_position

func change_target(new_target: Node2D, wait_time: float = 0) -> void:
	if _target:
		_prev_target = _target

	_target = new_target

	if wait_time:
		timer.wait_time = wait_time
		timer.start()

func _on_Timer_timeout() -> void:
	change_target(_prev_target)
