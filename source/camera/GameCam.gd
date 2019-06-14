extends Camera2D

var _target = null

export(NodePath) var target = null

func _ready() -> void:
	_target = get_node(target)
	print(target)

func _process(delta: float) -> void:
	global_position = _target.global_position