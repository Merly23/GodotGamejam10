extends Event
class_name Cutscene

signal started
signal finished

onready var dialoque := $Dialoque

func _ready() -> void:

	if not dialoque:
		print(name, " Dialoque is missing")
	else:
		dialoque.connect("finished", self, "_on_Dialoque_finished")

func _happen() -> void:
	if not requirements_fullfilled():
		return

	if delay:
		delay_timer.start(delay)
		yield(delay_timer, "timeout")

	emit_signal("started")
	dialoque.start()

func _on_Dialoque_finished() -> void:
	_set_on_enter(false)
	happened = true
	emit_signal("happened")
	emit_signal("finished")
