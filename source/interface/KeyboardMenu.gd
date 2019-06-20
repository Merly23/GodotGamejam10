extends Control
class_name KeyboardMenu

const style_normal = preload("res://graphics/themes/button_normal.tres")
const style_hover = preload("res://graphics/themes/button_hover.tres")
const style_pressed = preload("res://graphics/themes/button_pressed.tres")

var current_button_index := 0 setget _set_current_button_index
var current_button : Button = null

var buttons = []

func _ready() -> void:
	_register_buttons()
	_set_current_button_index(0, true)

func register_button(button) -> void:
	buttons.append(button)

func next_button() -> void:
	var index = (current_button_index + 1) % buttons.size()
	_set_current_button_index(index)

func previous_button() -> void:
	var index = current_button_index - 1

	if index < 0:
		index = buttons.size() - 1

	_set_current_button_index(index)

func _register_buttons() -> void:
	print("NO BUTTONS REGISTERED")

func _set_current_button_index(value, silent := false) -> void:

	if not buttons:
		return

	if current_button:
		current_button.emit_signal("mouse_exited")
		current_button.set("custom_styles/normal", style_normal)

	current_button_index = value
	current_button = buttons[current_button_index]
	current_button.set("custom_styles/normal", style_hover)
	if not silent:
		current_button.emit_signal("mouse_entered")