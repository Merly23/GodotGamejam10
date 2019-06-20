extends Button

func _on_MenuButton_mouse_entered() -> void:
	Audio.play_sfx("button_hover")

func _on_MenuButton_pressed() -> void:
	Audio.play_sfx("button_pressed")
