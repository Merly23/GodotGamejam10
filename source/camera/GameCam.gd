extends Camera2D

var _target : Character = null

var fake_position := Vector2()

export(NodePath) var target = null

func _ready() -> void:
	_target = get_node(target)
	fake_position = _target.global_position

func _process(delta: float) -> void:
	global_position = _target.global_position