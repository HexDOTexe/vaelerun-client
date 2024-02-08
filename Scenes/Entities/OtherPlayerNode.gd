extends Entity
class_name OtherPlayer

# PROPERTIES
var player_id

func _ready():
	# set default temp values until entity values can be loaded dynamically
	entity_type = EntityType.OTHER_PLAYER
	entity_state = EntityStates.IDLE
	entity_name = "Other Player"
	entity_class  = "Adventurer"
	entity_level = 1
	pass
