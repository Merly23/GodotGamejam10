extends StaticBody2D

export var locked := false

onready var coll := $CollisionShape2D as CollisionShape2D
onready var sprite := $Sprite as Sprite

func lock() -> void:
	locked = true

func unlock() -> void:
	locked = false

func open() -> void:
	sprite.visible = false
	coll.disabled = true

func close() -> void:
	sprite.visible = true
	coll.disabled = false