extends Control
class_name KeyboardMenu

const style_normal = preload("res://graphics/themes/button_normal.tres")
const style_hover = preload("res://graphics/themes/button_hover.tres")
const style_pressed = preload("res://graphics/themes/button_pressed.tres")

const PRESSED_TIME = 0.1

var current_button_index := 0 setget _set_current_button_index
var current_button : Button = null

var buttons = []

var pressed := true
var time := 0.0

func _process(delta: float) -> void:
	if pressed:
		time += delta
		if time > PRESSED_TIME:
			time = 0.0
			pressed = false
			_release_current_button()

func _ready() -> void:
	_register_buttons()
	_set_current_button_index(0, true)

	var idx := 0
	for button in buttons:
		button.connect("mouse_entered", self, "_on_Button_mouse_entered", [ idx ])
		idx += 1

func _register_button(button) -> void:
	buttons.append(button)

func _next_button() -> void:
	var index = (current_button_index + 1) % buttons.size()
	_set_current_button_index(index)

func _previous_button() -> void:
	var index = current_button_index - 1

	if index < 0:
		index = buttons.size() - 1

	_set_current_button_index(index)

func _register_buttons() -> void:
	print("NO BUTTONS REGISTERED")


func _release_current_button() -> void:
	current_button.set("custom_styles/normal", style_hover)

func _press_current_button() -> void:
	current_button.set("custom_styles/normal", style_pressed)
	current_button.emit_signal("pressed")
	pressed = true

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

func _on_Button_mouse_entered(index) -> void:
	_set_current_button_index(index, true)