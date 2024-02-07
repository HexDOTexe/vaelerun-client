extends Entity
class_name EntityNode

func _ready():
	# set default temp values until entity IDs can be loaded dynamically
	entity_type = "NPC"
	entity_state = EntityStates.IDLE
	entity_name = "Warmech"
	entity_class  = "Machine"
	entity_level = 10
	pass

func _physics_process(delta):
	pass

func _on_hitbox_mouse_entered():
	UserInterface.mouse_hover(self.name)

func _on_hitbox_mouse_exited():
	UserInterface.mouse_dehover(self.name)

#func load_resource():
	#entity_resource = load("res://Resources/Entities/"+str(entity_index_id)+".tres")

func update_entity(new_position):
	self.position = new_position
