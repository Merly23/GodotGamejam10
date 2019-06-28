extends Panel

func _ready() -> void:
	Glitch.level = 1

func _on_Back_pressed() -> void:
	Scene.change(Scene.TitleScreen)