extends Area2D
class_name Event

signal happened

var time := 0.0

var happened := false

var _targets := []
var _required_events := []

var expected_signals := 0
var signals := 0

export var active := true

export var delay := 0.0

export var on_input := false
export var input_action := ""
export var input_time := 0.2

export(Array, NodePath) var targets = null

export var on_enter := false
export var on_signal := ""

export(Array, NodePath) var required_events = null

onready var coll := $CollisionShape2D as CollisionShape2D

onready var delay_timer := $DelayTimer as Timer

func _ready() -> void:
	if targets:
		expected_signals = targets.size()

	_set_on_enter(on_enter)
	_setup_targets()
	_setup_required_events()

func _process(delta: float) -> void:
	if not on_input:
		set_process(false)

	if Input.is_action_pressed(input_action) and requirements_fullfilled():
		time += delta
		if time > input_time:
			time = 0.0
			_happen()
			set_process(false)
	elif time:
		time = 0.0

func _setup_targets() -> void:

	if not targets:
		return

	for target in targets:
		_targets.append(get_node(target))

	if not on_signal:
		return

	for target in _targets:
		target.connect(on_signal, self, "_on_Target_signal")

func _setup_required_events() -> void:

	if not required_events:
		return

	for req_e in required_events:

		_required_events.append(get_node(req_e))

func requirements_fullfilled() -> bool:

	if not _required_events:
		return not happened and active

	for req_e in _required_events:
		if not req_e.happened:
			return false
	return not happened and active

func _happen() -> void:
	if not requirements_fullfilled():
		return

	if delay:
		delay_timer.start(delay)
		yield(delay_timer, "timeout")

	_set_on_enter(false)
	happened = true
	emit_signal("happened")

func _set_on_enter(value):
	if coll:
		coll.disabled = !value

func _on_Target_signal() -> void:
	signals += 1

	if signals >= expected_signals:
		_happen()

func _on_Event_body_entered(body: PhysicsBody2D) -> void:

	if _targets.has(body):
		_happen()