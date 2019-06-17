extends Sprite

export var speed := 1600
export var damage := 1

var shooter : Character = null

var direction := 1

var fired := false

onready var area := $Area2D as Area2D

func _physics_process(delta: float) -> void:
	if fired:
		global_position.x += speed * delta * direction

func fire(flipped: bool) -> void:
	fired = true
	flip_h = flipped
	direction = -1 if flipped else 1

func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body is Character and shooter.team_number != body.team_number:
		body.hurt(damage)
		queue_free()
