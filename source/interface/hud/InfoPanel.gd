extends Control

var current_health := 3

onready var tween := $Tween as Tween
onready var anim := $AnimationPlayer as AnimationPlayer

onready var health_bar = [
	$HP1,
	$HP2,
	$HP3
]

onready var energy_bar := $EP

func update_health(health: int) -> void:

	if current_health > health:
		_hurt(current_health - health)
	elif current_health < health:
		_heal(health - current_health)

	current_health = health

func update_energy(energy: int) -> void:
	tween.interpolate_property(energy_bar, "value", energy_bar.value, energy, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()

func shake_energy_bar() -> void:
	anim.play("shake_energy_bar")

func _hurt(damage: int) -> void:
	for i in range(current_health, current_health - damage, -1):
		var idx = i - 1
		tween.interpolate_property(health_bar[idx], "value", 100, 0, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		tween.start()
		anim.play("hurt")

func _heal(value: int) -> void:
	for i in range(current_health, current_health + value):
		tween.interpolate_property(health_bar[i], "value", 0, 100, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		tween.start()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	pass # Replace with function body.
