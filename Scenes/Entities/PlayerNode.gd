extends Entity
class_name Player

# PROPERTIES
var client_character
var movement_vector : Vector2
var player_state

func _ready():
	set_physics_process(false)
	# set default temp values until entity values can be loaded dynamically
	entity_type = EntityType.PLAYER
	entity_state = EntityStates.IDLE
	entity_name = Server.temp_name
	entity_class  = "Adventurer"
	entity_level = 1
	health_maximum = 9999
	health_current = 9999
	health_percent = 100
	power_maximum = 9999
	power_current = 9999
	power_percent = 100
	move_speed_maximum= 50

func _physics_process(delta):
	player_movement(delta)
	define_player_state()

func _on_hitbox_mouse_entered():
	UserInterface.mouse_hover(self.name)

func _on_hitbox_mouse_exited():
	UserInterface.mouse_dehover(self.name)

func define_player_state():
	player_state = {"T": Time.get_unix_time_from_system(), "P": get_position()}
	Server.send_player_state(player_state)

func activate_camera():
	$Camera.enabled = true

func update_player():
	print("Function update_player called on local character - did client disconnect from server?")
	pass

func player_movement(_delta):
	movement_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movement_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	movement_vector = movement_vector.normalized()
	
	if movement_vector == Vector2(0, 0):
		move_speed_current = 0
	else:
		move_speed_current = 100
		if move_speed_current > move_speed_maximum:
			move_speed_current = move_speed_maximum
	
	if movement_vector:
		velocity = movement_vector * move_speed_current
	else:
		velocity = movement_vector
	
	move_and_slide()
