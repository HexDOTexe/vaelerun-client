extends Resource

enum EntityStates {IDLE, DEAD}
enum EntityType {PLAYER_SELF, PLAYER_OTHER, NPC, PROP}

# PROPERTIES
@export var entity_index_id : int
@export var entity_type : EntityType
@export var entity_state : EntityStates
@export var entity_sprite : CompressedTexture2D

@export var entity_name : String
@export var entity_class : String
@export var entity_level : int

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

func _init(p_health_maximum = 100):
	health_maximum = p_health_maximum
