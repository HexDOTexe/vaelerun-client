extends Entity
class_name EntityNode
# ENTITY NODE

var index_id: int = 0
var index: Resource

func _ready():
	load_index()
	load_index_values()

func _on_hitbox_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			UserInterface.select_target(self)
			print("clicked on "+self.name)

func set_index_id(id):
	index_id = id

func load_index():
	if !index_id == 0:
		var path = "res://Resources/Entities/"+str(index_id)+".tres"
		index = load(path)

func load_index_values():
	entity_type = index.entity_type
	entity_state = index.entity_state
	$Sprite.texture = index.entity_sprite
	entity_name = index.entity_name
	entity_class = index.entity_class
	entity_level = index.entity_level
	health_maximum = index.health_maximum
	health_current = index.health_current
	power_type = index.power_type
	power_maximum = index.power_maximum
	power_current = index.power_current
	
