extends Area2D

signal started
signal finished

var time := 0.0

var seen := false

var _targets : Node = null
var _required_dialoques := []

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

export(Array, NodePath) var required_dialoques = null

onready var coll := $CollisionShape2D as CollisionShape2D
onready var dialoque := $Dialoque

onready var delay_timer := $DelayTimer as Timer

func _ready() -> void:
	if targets:
		expected_signals = targets.size()

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

	if not targets:
		return

	for target in targets:
		_targets.append(get_node(targets))

	if not on_signal:
		return

	for target in targets:
		target.connect(on_signal, self, "_on_Target_signal")

func _setup_requires_dialoque() -> void:

	if not required_dialoques:
		return

	for req_d in required_dialoques:

		_required_dialoques.append(get_node(req_d))

func requirement_fullfilled() -> bool:

	if not _required_dialoques:
		return true

	for req_d in _required_dialoques:
		if not req_d.seen:
			return false
	return true

func _start() -> void:
	if active and dialoque and requirement_fullfilled() and not seen:

		if delay:
			delay_timer.start(delay)
			yield(delay_timer, "timeout")

		emit_signal("started")
		dialoque.start()

func _set_on_enter(value):
	if coll:
		coll.disabled = !value

func _on_Target_signal() -> void:
	signals += 1

	if signals >= expected_signals:
		_start()

func _on_Cutscene_body_entered(body: PhysicsBody2D) -> void:

	if _targets.has(body):
		_start()

func _on_Dialoque_finished() -> void:
	_set_on_enter(false)
	seen = true
	emit_signal("finished")
