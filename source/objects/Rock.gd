extends Node2D

onready var rock := $Rock as Area2D

export var damage := 25

var motion = 0

func _physics_process(delta: float) -> void:
	motion = clamp(motion + 20, 0, 250)
	rock.global_position.y += motion * delta

func _on_Rock_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		body.hurt(global_position, damage)
		queue_free()
	elif not body is Character:
		queue_free()
