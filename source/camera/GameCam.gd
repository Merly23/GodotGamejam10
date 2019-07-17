extends Camera2D
class_name GameCam

var _target = null
var _prev_target = null

onready var timer := $Timer as Timer
onready var tween := $Tween as Tween

func _ready():
	offset = Vector2(0, 0)

func _process(delta: float) -> void:
	if _target:
		global_position = _target.global_position

func shake(amplitude: int) -> void:
	var new_offset = Vector2(rand_range(-amplitude, amplitude), rand_range(-amplitude, amplitude))
	tween.interpolate_property(self, "offset", offset, new_offset, 0.1, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.interpolate_property(self, "offset", offset, Vector2(0, 0), 0.1, Tween.TRANS_SINE, Tween.EASE_OUT, 0.1)
	tween.start()

func change_target(new_target: Node2D, wait_time: float = 0) -> void:
	if _target:
		_prev_target = _target

	_target = new_target

	if wait_time:
		timer.start(wait_time)

func _on_Timer_timeout() -> void:
	change_target(_prev_target)
