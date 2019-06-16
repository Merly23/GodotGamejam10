extends CanvasLayer
class_name Interface

onready var info_panel := $InfoPanel

func show() -> void:
	info_panel.show()

func hide() -> void:
	info_panel.hide()