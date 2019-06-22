extends Patrol
class_name Glitcher

export var damage := 2

func attack():
	var bodies = hit_area.get_overlapping_bodies()

	Audio.play_sfx("player_slash")

	for body in bodies:
		if body is Character and body.team_number != team_number:
			body.hurt(damage)
