extends CanvasLayer
class_name Interface

onready var info_panel := $InfoPanel

func update_health(health: int) -> void:
	info_panel.update_health(health)

func show() -> void:
	info_panel.show()

func hide() -> void:
	info_panel.hide()