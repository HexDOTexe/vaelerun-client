extends Entity
class_name EntityNode
# ENTITY NODE

func _ready():
	# set default temp values until entity values can be loaded dynamically
	entity_type = EntityType.NPC
	entity_state = EntityStates.IDLE
	entity_name = "Warmech"
	entity_class  = "Machine"
	entity_level = 10
	pass

func _on_hitbox_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			UserInterface.select_target(self)
			print("clicked on "+self.name)
			
