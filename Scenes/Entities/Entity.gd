extends CharacterBody2D
class_name Entity

enum EntityStates {IDLE, DEAD}

# PROPERTIES
@export var entity_index_id : int
@export var entity_type : String
@export var entity_state : EntityStates

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

#func _init(type, iName):
#	entity_type = type
#	entity_name = iName

func _ready():
	pass

func _physics_process(delta):
	pass

func _on_hitbox_mouse_entered():
	UserInterface.mouse_hover(self.name)

func _on_hitbox_mouse_exited():
	UserInterface.mouse_dehover(self.name)

func update_entity(new_position):
	self.position = new_position
