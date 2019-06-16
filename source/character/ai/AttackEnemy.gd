extends State

func enter(host: Node) -> void:
    host = host as Character
    host.play("walk")

func input(host: Node, event: InputEvent) -> void:
    host = host as Character

func update(host: Node, delta: float) -> void:
	host = host as Character
	if(host.enemy != null):
		_face_toward_enemy(host.enemy)
		_can_attack(host.enemy)
	
		if(host.can_attack_enemy):
			_attack(host.enemy)
		else:
			_move_towards_enemy(host.enemy)
	else:
		host.fsm.change_state("Search")
	

func exit(host: Node) -> void:
    host = host as Character
	
	
func _can_attack(enemy):
	var distance_from_enemy = host.get_global_position().distance_to(host.enemy.get_global_position())
	if(weapon_type == 1):
		if(distance_from_enemy <= host.gun_range && distance_from_enemy >= host.gun_range * -1):
			host.can_attack_enemy = true
	if(weapon_type == 2):
		if(distance_from_enemy <= host.melee_range && distance_from_enemy >= host.melee_range * -1):
			host.can_attack_enemy = true
	else:
		host.can_attack_enemy = false

func _attack(enemy):
	var weapon = host.weapon_type


func _move_towards_enemy(enemy):
	var enemy_direction = host.get_global_position().distance_to(host.enemy.get_global_position())
	if(enemy_direction <= 0):
		host.direction = host.direction * -1
		sprite.flip_v = true
		host.DetectionArea.position.x += 150 * host.direction
	else:
		host.direction = host.direction * -1
		sprite.flip_v = true
		host.DetectionArea.position.x += 150 * host.direction

func _face_toward_enemy(enemy):
	var enemy_direction = host.get_global_position().distance_to(host.enemy.get_global_position())
	if(enemy_direction <= 0):
		host.direction = -1
		sprite.flip_v = true
	else:
		host.direction = 1
		sprite.flip_v = true