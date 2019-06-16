extends Character

enum AI_TYPES { NONE, DRONE, TURRET, ALIEN, SCIENTIST}

export(AI_TYPES) var ai_type := AI_TYPES.DRONE

onready var detection_area := $DetectionArea

const Gravity = 10
const Speed = 30
const Floor = Vector2(0,-1)

var velocity = Vector2()
var sight_box
var sprite
var enemy
var sees_enemy = false
var can_attack_enemy = false
var host = host as Character

export(int) var team_name := 2
export(Array) var enemy_teams := [1, 3]
export(int) var weapon_type := 1
export(int) var gun_range := 150
export(int) var melee_range := 20
export(int) var direction = 1

func _ready() -> void:
	fsm.change_state("search")

func _register_states() -> void:
	fsm.register_state("search", "Search")
	fsm.register_state("attackenemy", "AttackEnemy")