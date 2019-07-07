extends Node2D

onready var ray := $Rock/RayCast2D as RayCast2D
onready var rock := $Rock as Area2D

export var damage := 1

var loose := false

var motion = 0

func _process(delta: float) -> void:
	if is_character_in_reach():
		loose = true
	elif loose:
		motion += (Global.GRAVITY * delta * delta) / 2
		rock.global_position.y += motion
#		print("looooose")

func loosen():
	loose = true

func is_character_in_reach() -> bool:
	if not ray:
		return false

	var collider = ray.get_collider()

	return collider is Character and not loose

func _on_Rock_body_entered(body: PhysicsBody2D) -> void:
	if body is Character:
		body.hurt(global_position, damage)
		queue_free()
	elif not body is Character:
		queue_free()
