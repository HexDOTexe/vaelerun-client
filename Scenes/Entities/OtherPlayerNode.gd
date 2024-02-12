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

func _on_hitbox_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			UserInterface.select_target(self)
			print("clicked on "+self.name)
