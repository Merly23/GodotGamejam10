extends State

var velocity = Vector2()
const Gravity = 10
const Speed = 30
const Floor = Vector2(0,-1)

func enter(host: Node) -> void:
	host = host as Character
	host.play("walk")
	pass

func input(host: Node, event: InputEvent) -> void:
    host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character
	_move()
	_check_for_enemies()
	if(host.sees_enemy):
		host.fsm.change_state("attackenemy")

func exit(host: Node) -> void:
    host = host as Character
	
	

func _move():
	var direction = host.direction
	velocity.x = Speed * host.direction
	velocity.y += Gravity
	velocity = host.move_and_slide(velocity, Floor)
	if(host.is_on_wall()):
		host.direction = host.direction * -1
		

func _check_for_enemies():
	var seen_objects = host.DetectionArea.get_overlapping_bodies()

	for KinematicBody2D in seen_objects:
		#gets the kinematic body of seen bodies and their team association
		var kinematic_parent = KinematicBody2D.get_parent()
		var seen_objects_team = kinematic_parent.team_name

		if seen_objects_team != null:
			for item in enemy_teams:
				#checks if the team association of the kinematic body is on the list of enemy teams
				if(item != seen_objects_team):
					print("enemy")
					host.sees_enemy =  true
					host.enemy = kinematic_parent
				else:
					host.sees_enemy = false