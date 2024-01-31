extends Resource
class_name Entity

enum entity_states {IDLE, DEAD}

# PROPERTIES
@export var entity_index_id : int
@export var entity_name : String
@export var entity_state : entity_states

@export var health_maximum : int
@export var health_current : int
@export var health_percent : int

@export var power_type : String

@export var power_maximum : int
@export var power_current : int
@export var power_percent : int

@export var move_speed_base : int
@export var move_speed_walking : int
@export var move_speed_current : int
@export var move_speed_maximum : int
