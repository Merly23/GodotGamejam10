extends Panel

onready var load_button := $CenterContainer/VBoxContainer/Buttons/Load as Button

func _ready() -> void:
	Audio.play_music("menu_music")
	Glitch.level = 1

	if SaveGame.current_level:
		load_button.visible = true

func _on_Play_pressed() -> void:
	Scene.change(Scene.Level1)

func _on_Credits_pressed() -> void:
	Scene.change(Scene.Credits)

func _on_Quit_pressed() -> void:
	get_tree().quit()

func _on_Load_pressed() -> void:
	Scene.change(SaveGame.current_level)

func _on_Settings_pressed() -> void:
	Scene.change(Scene.Settings)
