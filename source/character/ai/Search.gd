extends State

var velocity = Vector2()
const Gravity = 10
const Speed = 30
const Floor = Vector2(0,-1)
var host = host as Character
var found_enemy = false

func enter(host: Node) -> void:
	host = host as Character
	#host.play("walk")
	pass

func input(host: Node, event: InputEvent) -> void:
    host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character
	_move(host)
	_check_for_enemies(host)
	if(found_enemy):
		host.fsm.change_state("attackenemy")
		host.fsm.change_state("AttackEnemy")
		print("attacking")

func exit(host: Node) -> void:
    host = host as Character
	
	

func _move(host):
	host = host as Character
	#var host_direction = host.direction
	velocity.x = Speed * host.direction
	velocity.y += Gravity
	velocity = host.move_and_slide(velocity, Floor)
	if(host.is_on_wall()):
		host.direction = host.direction * -1
		

func _check_for_enemies(host):
	#host = host as Character
	var seen_objects = host.detection_area.get_overlapping_bodies()

	for KinematicBody2D in seen_objects:
		#gets the kinematic body of seen bodies and their team association
		var seen_objects_team = KinematicBody2D.get("team_number")
		if seen_objects_team != null:
			for item in host.enemy_teams:
				#checks if the team association of the kinematic body is on the list of enemy teams
				if(item == seen_objects_team):
					print("enemy")
					host.sees_enemy =  true
					found_enemy = true
					host.enemy = KinematicBody2D
				else:
					host.sees_enemy = false
					found_enemy = true