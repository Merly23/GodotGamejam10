extends StaticBody2D

export var locked := false
export var automatic := false

onready var close_timer := $CloseTimer as Timer

onready var coll := $CollisionShape2D as CollisionShape2D
onready var sprite := $Sprite as Sprite

onready var enter_area := $EnterArea as Area2D

func lock() -> void:
	locked = true

func unlock() -> void:
	locked = false

func open() -> void:
	if locked:
		return

	sprite.visible = false
	coll.disabled = true

	global_position.y -= 96

func close() -> void:
	sprite.visible = true
	coll.disabled = false

	global_position.y += 96
func _on_EnterArea_body_entered(body) -> void:
	if automatic and close_timer.is_stopped():
		close_timer.start()
		open()

func _on_CloseTimer_timeout() -> void:
	close()