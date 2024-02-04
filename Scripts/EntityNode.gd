extends CharacterBody2D
class_name EntityNode

# PROPERTIES
var entity_index_id : int
var entity_resource : Entity
var entity_type : String = "NPC"
var entity_state

var entity_name : String = "Warmech"
var entity_class : String = "Machine"
var entity_level : int = 10

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

func load_resource():
	entity_resource = load("res://Resources/Entities/"+str(entity_index_id)+".tres")

func update_entity(new_position):
	self.position = new_position

func _on_hitbox_mouse_entered():
	UserInterface.mouse_hover(self)

func _on_hitbox_mouse_exited():
	UserInterface.mouse_dehover(self)
