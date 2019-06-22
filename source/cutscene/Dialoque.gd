extends CanvasLayer

signal finished

onready var speeches := get_children()

var current_index := -1
var current_speech

func _input(event: InputEvent) -> void:
	if current_speech:
		current_speech.input(event)

func _ready() -> void:
	for speech in speeches:
		speech.hide()
		speech.connect("finished", self, "_on_Speech_finished")

func start():
	_on_Speech_finished()

func _on_Speech_finished() -> void:
	if current_speech:
		current_speech.hide()

	current_index += 1

	if current_index == get_child_count():
		set_process_input(false)
		yield(get_tree().create_timer(0.2), "timeout")
		emit_signal("finished")
		current_speech = null
	else:
		current_speech = get_child(current_index)
		current_speech.show()
		current_speech.next_line()
