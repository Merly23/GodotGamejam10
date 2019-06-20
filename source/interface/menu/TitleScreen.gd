extends KeyboardMenu

func _input(event: InputEvent) -> void:

	if not buttons:
		return

	if event.is_action_pressed("ui_down"):
		next_button()
	elif event.is_action_pressed("ui_up"):
		previous_button()
	elif event.is_action_pressed("ui_accept"):
		current_button.set("custom_styles/normal", style_pressed)
		current_button.emit_signal("pressed")

func _ready() -> void:
	Audio.play_music("menu_music")
	Glitch.level = 1

func _on_Play_pressed() -> void:
	Scene.change(Scene.Level1)

func _on_Quit_pressed() -> void:
	get_tree().quit()

func _register_buttons() -> void:
	register_button($CenterContainer/VBoxContainer/Buttons/Play)
	register_button($CenterContainer/VBoxContainer/Buttons/Credits)
	register_button($CenterContainer/VBoxContainer/Buttons/Controls)
	register_button($CenterContainer/VBoxContainer/Buttons/Quit)