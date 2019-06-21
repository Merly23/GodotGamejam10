extends KeyboardMenu

func _input(event: InputEvent) -> void:

	if not buttons:
		return

	if event.is_action_pressed("ui_down"):
		_next_button()
	elif event.is_action_pressed("ui_up"):
		_previous_button()
	elif event.is_action_pressed("ui_accept"):
		_press_current_button()

func _ready() -> void:
	Audio.play_music("menu_music")
	Glitch.level = 0

func _on_Play_pressed() -> void:
	Scene.change(Scene.Level1)

func _on_Quit_pressed() -> void:
	get_tree().quit()

func _register_buttons() -> void:
	_register_button($CenterContainer/VBoxContainer/Buttons/Play)
	_register_button($CenterContainer/VBoxContainer/Buttons/Credits)
	_register_button($CenterContainer/VBoxContainer/Buttons/Controls)
	_register_button($CenterContainer/VBoxContainer/Buttons/Quit)