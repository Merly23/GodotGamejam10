extends Camera2D

var _target : Character = null

var fake_position := Vector2()

export(NodePath) var target = null

func _ready() -> void:
	_target = get_node(target)
	fake_position = _target.global_position

func _process(delta: float) -> void:
	global_position = _target.global_position

	if _target.motion.x:
		global_position.x += _target.motion.x / 2.5
		var factor = 1 + abs(_target.motion.x) / 2000
		zoom = Vector2(factor, factor)