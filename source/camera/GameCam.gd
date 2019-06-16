extends Camera2D
class_name GameCam

var _target : Character = null

var fake_position := Vector2()

export(NodePath) var target = null

onready var screen_shake := $ScreenShake as ScreenShake

func _ready() -> void:
	if target:
		_target = get_node(target)
		fake_position = _target.global_position

func _process(delta: float) -> void:
	global_position = _target.global_position