extends Entity
class_name EntityNode

func _ready():
	# set default temp values until entity values can be loaded dynamically
	entity_type = EntityType.NPC
	entity_state = EntityStates.IDLE
	entity_name = "Warmech"
	entity_class  = "Machine"
	entity_level = 10
	pass
