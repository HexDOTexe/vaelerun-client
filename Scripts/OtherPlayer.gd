extends CharacterBody2D

# PROPERTIES
var entity_type : String = "Player"
var entity_state : String = "Idle"
var player_id

var entity_name : String = "Player"
var entity_class : String = "Adventurer"
var entity_level : int = 1

func update_player(new_position):
	self.position = new_position

func _on_hitbox_mouse_entered():
	UserInterface.mouse_hover(self)

func _on_hitbox_mouse_exited():
	UserInterface.mouse_dehover(self)
