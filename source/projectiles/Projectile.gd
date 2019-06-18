extends Sprite

var speed := 1600
var damage := 1

var shooter : Character = null

var direction := 1

var fired := false

onready var area := $Area2D as Area2D

func _physics_process(delta: float) -> void:
	if fired:
		global_position.x += speed * delta * direction

func fire(speed: int, damage: int, flipped: bool) -> void:
	self.speed = speed
	self.damage = damage

	self.flip_h = flipped

	self.fired = true
	self.direction = -1 if flipped else 1

func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body is Character and shooter.team_number != body.team_number:
		body.hurt(damage)
		queue_free()
