extends Node2D

onready var interface := $Interface as Interface


onready var cutscenes := $Cutscenes.get_children()

func _ready() -> void:
	for cutscene in cutscenes:
		cutscene.connect("started", self, "_on_Cutscene_started")
		cutscene.connect("finished", self, "_on_Cutscene_finished")

func _on_Cutscene_started() -> void:
	interface.hide()
	Global.Player.disabled = true

func _on_Cutscene_finished() -> void:
	yield(get_tree().create_timer(0.2), "timeout")
	interface.show()
	Global.Player.disabled = false
