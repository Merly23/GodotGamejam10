extends Panel

func _ready() -> void:
	Audio.play_music("menu_music")

func _on_Play_pressed() -> void:
	Scene.change(Scene.Level1)

func _on_Quit_pressed() -> void:
	get_tree().quit()