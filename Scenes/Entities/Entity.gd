extends CharacterBody2D
class_name Entity

enum EntityStates {IDLE, DEAD}
enum EntityType {PLAYER, OTHER_PLAYER, NPC, PROP}

# PROPERTIES
var entity_index_id : int
var entity_type : EntityType
var entity_state : EntityStates

var entity_name : String
var entity_class : String
var entity_level : int

var health_maximum : int
var health_current : int
var health_percent : int

var power_type : String
var power_maximum : int
var power_current : int
var power_percent : int

var move_speed_base : int
var move_speed_walking : int
var move_speed_current : int
var move_speed_maximum : int

#func _init(type, iName):
#	entity_type = type
#	entity_name = iName

func _ready():
	pass

func _physics_process(_delta):
	pass

func _on_hitbox_mouse_entered():
	UserInterface.mouse_hover(self.name)

func _on_hitbox_mouse_exited():
	UserInterface.mouse_dehover(self.name)

func update_entity_name(new_name):
	self.entity_name = new_name

func update_entity_position(new_position):
	self.position = new_position

func update_entity_state(new_state):
	self.entity_state = new_state
