extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const Gravity = 10
const Speed = 30
const Floor = Vector2(0,-1)

var velocity = Vector2()

var direction = 1

var sight_box
var sprite

export(int) var team_name := 2
export(Array) var enemy_teams := [1, 3]

func _ready():
	set_physics_process(true)
	
	sight_box = $"SightBoxArea"
	sprite = $"Sprite"
	team_name = self.get("team_name")
	
	pass # Replace with function body.

func _physics_process(delta):
	
	velocity.x = Speed * direction
	velocity.y += Gravity
	velocity = move_and_slide(velocity, Floor)
	
	_check_for_enemies(sight_box)
	
	if is_on_wall():
		direction = direction * -1
		sprite.flip_v = true
		sight_box.position.x += 100 * direction
		

func _check_for_enemies(sight_box):
	var seen_objects = sight_box.get_overlapping_bodies()
	
	for KinematicBody2D in seen_objects:
		var kinematic_parent = KinematicBody2D.get_parent()
		var seen_objects_team = kinematic_parent.get("team_name")
		if seen_objects_team != null:
			for item in enemy_teams:
				if(item != seen_objects_team):
					print("enemy")