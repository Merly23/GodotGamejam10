extends State

const BITE_TIME := 0.8

var time := 0.0

func enter(host: Node) -> void:
	host = host as Clasher
	time = 0.0
	host.anim_player.play("attack")

func update(host: Node, delta: float) -> void:
	host = host as Clasher

	time += delta

	if time > BITE_TIME:
		if host.is_player_in_bite_range():
			host.fsm.change_state("bite")
		else:
			host.fsm.change_state("seek")
