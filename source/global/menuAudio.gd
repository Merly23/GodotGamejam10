extends "res://source/global/Audio.gd"

var mixing_desk
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	mixing_desk = get_node("/root/Audio/MixingDeskMusic")
	mixing_desk._init_song("menuMusic")
	mixing_desk._play("menuMusic")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_pressed():
	#fades out menu, fades in level music
	mixing_desk._init_song("levelMusic")
	mixing_desk._fade_out("menuMusic", 0)
	mixing_desk._play("levelMusic")
	mixing_desk._fade_in("levelMusic", 0)
	#get_node("/root/Audio/MixingDeskMusic")._play("levelMusic")
	pass # Replace with function body.
