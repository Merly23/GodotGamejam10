extends Character

enum AI_TYPES { NONE, DRONE, TURRET, ALIEN, SCIENTIST}

export(AI_TYPES) var ai_type := AI_TYPES.DRONE

onready var detection_area := $DetectionArea

