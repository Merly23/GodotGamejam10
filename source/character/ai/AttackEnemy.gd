extends State

var host = host as Character
var velocity = Vector2()
const Gravity = 10
const Speed = 30
const Floor = Vector2(0,-1)

func enter(host: Node) -> void:
    host = host as Character
   # host.play("walk")

func input(host: Node, event: InputEvent) -> void:
    host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character
	if(host.enemy != null):
		#_face_toward_enemy(host.enemy)
		_can_attack(host)
	
		if(host.can_attack_enemy):
			_attack(host)
		else:
			_move_towards_enemy(host)
	else:
		host.fsm.change_state("Search")
	

func exit(host: Node) -> void:
    host = host as Character
	
	
func _can_attack(host):
	#host = host as Character
	var distance_from_enemy = host.get_global_position().distance_to(host.enemy.get_global_position())
	if(host.weapon_type == 1):
		if(distance_from_enemy <= host.gun_range && distance_from_enemy >= host.gun_range * -1):
			host.can_attack_enemy = true
	if(host.weapon_type == 2):
		if(distance_from_enemy <= host.melee_range && distance_from_enemy >= host.melee_range * -1):
			host.can_attack_enemy = true
	else:
		host.can_attack_enemy = false

func _attack(host):
	#host = host as Character
	var weapon = host.weapon_type


func _move_towards_enemy(host):
	#host = host as Character
	var enemy_direction = host.global_position.distance_to(host.enemy.global_position)
	if(enemy_direction <= 0 && host.direction != -1):
		print(enemy_direction)
		host.direction = -1
		host.flip_left()
		host.detection_area.position.x += 150 * host.direction
	if(enemy_direction >= 0 && host.direction != 1):
		print(enemy_direction)
		host.direction = 1
		host.flip_right()
		host.detection_area.position.x += 150 * host.direction
	
	velocity.x = Speed * host.direction
	velocity.y += Gravity
	velocity = host.move_and_slide(velocity, Floor)

func _face_toward_enemy(host):
	#host = host as Character
	var enemy_direction = host.get_global_position().distance_to(host.enemy.get_global_position())
	if(enemy_direction <= 0 && host.direction != -1):
		host.direction = -1
		host.flip_left()
	if(enemy_direction >= 0 && host.direction != 1):
		host.direction = 1
		host.flip_right()