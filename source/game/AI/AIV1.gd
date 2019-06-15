extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const Gravity = 10
const Speed = 30
const Floor = Vector2(0,-1)

var velocity = Vector2()
var sight_box
var sprite
var enemy
var sees_enemy = false
var can_attack_enemy = false

export(int) var team_name := 2
export(Array) var enemy_teams := [1, 3]
export(int) var weapon_type := 1
export(int) var gun_range := 150
export(int) var melee_range := 20
export(int) var direction = 1
export(int) var ai_type = 0

func _ready():
	set_physics_process(true)
	
	sight_box = $"SightBoxArea"
	sprite = $"Sprite"
	team_name = self.get("team_name")
	ai_type = self.get("ai_type")
	weapon_type = self.get("weapon_type")
	
	if(ai_type == 0):
		print(0)
	if(ai_type == 1):
		print(1)
	if(ai_type == 2):
		print(2)
	if(ai_type == 3):
		print(3)
	
	pass # Replace with function body.

func _physics_process(delta):
	
	velocity.x = Speed * direction
	velocity.y += Gravity
	velocity = move_and_slide(velocity, Floor)
	
	_check_for_enemies(sight_box)
	
	if(sees_enemy):
		_face_toward_enemy(enemy)
		_can_attack(enemy)
		if(can_attack_enemy):
			_attack(enemy)
		else:
			_move_towards_enemy(enemy)
	else:
		if is_on_wall():
			direction = direction * -1
			sprite.flip_v = true
			sight_box.position.x += 150 * direction
		

func _can_attack(enemy):
	var distance_from_enemy = self.get_global_position().distance_to(enemy.get_global_position())
	if(weapon_type == 1):
		if(distance_from_enemy <= gun_range && distance_from_enemy >= gun_range * -1):
			can_attack_enemy = true
	if(weapon_type == 2):
		if(distance_from_enemy <= melee_range && distance_from_enemy >= melee_range * -1):
			can_attack_enemy = true
	else:
		can_attack_enemy = false

func _attack(enemy):
	var weapon = self.get("weapon_type")
	

func _move_towards_enemy(enemy):
	var enemy_direction = self.get_global_position().distance_to(enemy.get_global_position())
	if(enemy_direction <= 0):
		direction = direction * -1
		sprite.flip_v = true
		sight_box.position.x += 150 * direction
	else:
		direction = direction * -1
		sprite.flip_v = true
		sight_box.position.x += 150 * direction

func _face_toward_enemy(enemy):
	var enemy_direction = self.get_global_position().distance_to(enemy.get_global_position())
	if(enemy_direction <= 0):
		direction = -1
		sprite.flip_v = true
	else:
		direction = 1
		sprite.flip_v = true

func _check_for_enemies(sight_box):
	var seen_objects = sight_box.get_overlapping_bodies()
	
	for KinematicBody2D in seen_objects:
		var kinematic_parent = KinematicBody2D.get_parent()
		var seen_objects_team = kinematic_parent.get("team_name")
		
		if seen_objects_team != null:
			for item in enemy_teams:
				if(item != seen_objects_team):
					print("enemy")
					sees_enemy = true
					enemy = kinematic_parent
				else:
					sees_enemy = false