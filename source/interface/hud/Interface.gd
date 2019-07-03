extends CanvasLayer
class_name Interface

onready var raphie_plate := $RaphiePlate
onready var key_preview := $KeyPreview

func show_key(key: String) -> void:
	key_preview.new_key(key)

func hide_key():
	key_preview.clear()

func show() -> void:
	raphie_plate.show()

func hide() -> void:
	raphie_plate.hide()
