extends NinePatchRect

const masks = [
	preload("res://graphics/images/misc/displacement.png"),
	preload("res://graphics/images/misc/displacement2.png"),
	preload("res://graphics/images/misc/displacement3.png"),
]

export var wait_time_from := 3.0
export var wait_time_to := 6.0

var offset := 0.0 setget _set_offset
var abberation := 0.0 setget _set_abberation

onready var wait = $Wait as Timer
onready var glitch = $Glitch as Timer

func _ready() -> void:
	_set_abberation(0.001)
	wait.wait_time = _new_time()
	wait.start()

func _new_time() -> float:
	randomize()
	return rand_range(wait_time_from, wait_time_to)

func _set_offset(value) -> void:
	offset = value
	material.set_shader_param("offset", offset)
	_set_abberation(rand_range(0.001, offset))

func _set_abberation(value) -> void:
	abberation = value
	material.set_shader_param("abberation", abberation)

func _on_Timer_timeout() -> void:
	_set_offset(rand_range(0.0, 0.05))
	Audio.play_sfx("glitch")
	glitch.wait_time = rand_range(0.05, 1.0)
	glitch.start()

func _on_Glitch_timeout() -> void:
	_set_offset(0.0)
	_set_abberation(0.001)
	wait.wait_time = _new_time()
	wait.start()

func _on_Mask_timeout() -> void:
	material.set_shader_param("mask", masks[randi() % masks.size()])