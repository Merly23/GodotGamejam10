extends Area2D

signal started
signal finished

var time := 0.0

var seen := false

var _target : Node = null
var _requires_dialoque = null

export var active := true

export var on_input := false
export var input_action := ""
export var input_time := 0.2

export(NodePath) var target = null

export var on_enter := false
export var on_signal := ""

export(NodePath) var requires_dialoque = null

onready var coll := $CollisionShape2D as CollisionShape2D
onready var dialoque := $Dialoque

func _ready() -> void:
	_set_on_enter(on_enter)
	_setup_target()
	_setup_requires_dialoque()

	if not dialoque:
		print(name, " Dialoque is missing")
	else:
		dialoque.connect("finished", self, "_on_Dialoque_finished")

func _process(delta: float) -> void:
	if not on_input:
		set_process(false)

	if Input.is_action_pressed(input_action) and requirement_fullfilled():
		time += delta
		if time > input_time:
			time = 0.0
			_start()
			set_process(false)
	elif time:
		time = 0.0

func _setup_target() -> void:

	if not target:
		return

	_target = get_node(target)

	if not on_signal:
		return

	_target.connect(on_signal, self, "_on_Target_signal")

func _setup_requires_dialoque() -> void:

	if not requires_dialoque:
		return

	_requires_dialoque = get_node(requires_dialoque)

func requirement_fullfilled() -> bool:

	if not _requires_dialoque:
		return true

	return _requires_dialoque.seen

func _start() -> void:
	if active and dialoque and requirement_fullfilled() and not seen:
		emit_signal("started")
		dialoque.start()

func _set_on_enter(value):
	if coll:
		coll.disabled = !value

func _on_Target_signal() -> void:
	_start()

func _on_Cutscene_body_entered(body: PhysicsBody2D) -> void:

	if body == _target:
		_start()

func _on_Dialoque_finished() -> void:
	_set_on_enter(false)
	seen = true
	emit_signal("finished")
