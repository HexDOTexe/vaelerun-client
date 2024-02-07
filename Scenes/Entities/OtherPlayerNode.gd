extends CharacterBody2D

# PROPERTIES
var entity_type : String = "Player"
var entity_state : String = "Idle"
var player_id

var entity_name : String = "Player"
var entity_class : String = "Adventurer"
var entity_level : int = 1

func _physics_process(delta):
	pass

func _on_hitbox_mouse_entered():
	UserInterface.mouse_hover(self.name)

func _on_hitbox_mouse_exited():
	UserInterface.mouse_dehover(self.name)

func update_player(new_position):
	self.position = new_position
