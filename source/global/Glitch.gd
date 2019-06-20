extends CanvasLayer

export var level := 1.0 setget _set_level

onready var glitch := $Glitch

func _set_level(value):
	level = value
	glitch.level = level
