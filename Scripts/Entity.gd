extends CharacterBody2D
class_name Entity

# PROPERTIES
var entity_type
var entity_name

var stat_health_maximum : int
var stat_health_current : int
var stat_health_percent : int

var stat_power_type : String

var stat_mana_maximum : int
var stat_mana_current : int
var stat_mana_percent : int

var stat_movement_speed_base : int
var stat_movement_speed_walking : int
var stat_movement_speed_current : int = 50
var stat_movement_speed_maximum : int
var stat_movement_speed_acceleration : int

#func _init(type, iName):
#	entity_type = type
#	entity_name = iName

func _ready():
	pass

func update_entity(new_position):
	self.position = new_position
