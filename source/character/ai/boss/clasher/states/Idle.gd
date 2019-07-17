extends State

func enter(host: Node) -> void:
	host = host as Clasher
	
	host.anim_player.play("idle")