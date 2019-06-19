extends Sprite

onready var anim := $AnimationPlayer

func play() -> void:
	rotation_degrees = randi() % 360
	anim.play("spark")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()