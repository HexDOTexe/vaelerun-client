extends Resource
class_name Entity

enum entity_states {IDLE, DEAD}

# PROPERTIES
@export var entity_type : String
@export var entity_id : int
@export var entity_name : String
@export var entity_state : entity_states

@export var stat_health_maximum : int
@export var stat_health_current : int
@export var stat_health_percent : int

@export var stat_power_type : String

@export var stat_mana_maximum : int
@export var stat_mana_current : int
@export var stat_mana_percent : int

@export var stat_movement_speed_base : int
@export var stat_movement_speed_walking : int
@export var stat_movement_speed_current : int = 50
@export var stat_movement_speed_maximum : int
@export var stat_movement_speed_acceleration : int
