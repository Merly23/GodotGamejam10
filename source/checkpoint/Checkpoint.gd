extends Area2D

signal checkpoint_reached(id)

export var id := 0

func _on_Checkpoint_body_entered(body: PhysicsBody2D) -> void:
	if body == Global.Player:
		emit_signal("checkpoint_reached", id)