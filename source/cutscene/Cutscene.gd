extends Area2D

signal started
signal finished

var seen := false

export var active := true

onready var dialoque := $Dialoque
onready var coll := $CollisionShape2D as CollisionShape2D

func _ready() -> void:
	coll.disabled = !active

	if not dialoque:
		print(name, " Dialoque is missing")
	else:
		dialoque.connect("finished", self, "_on_Dialoque_finished")

func _on_Cutscene_body_entered(body: PhysicsBody2D) -> void:
	if body == Global.Player and not seen and dialoque:
		emit_signal("started")
		dialoque.start()

func _on_Dialoque_finished() -> void:
	seen = true
	emit_signal("finished")
