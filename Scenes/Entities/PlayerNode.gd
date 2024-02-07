extends CharacterBody2D
class_name Player

# PROPERTIES
var entity_type : String = "Player"
var entity_state : String = "Idle"

var entity_name : String = "Player"
var entity_class : String = "Adventurer"
var entity_level : int = 1

var stat_health_maximum : int
var stat_health_current : int
var stat_health_percent : int

var stat_power_type : String
var stat_power_maximum : int
var stat_power_current : int
var stat_power_percent : int

var stat_movement_speed_base : int
var stat_movement_speed_walking : int
var stat_movement_speed_current : int = 0
var stat_movement_speed_maximum : int = 100
var stat_movement_speed_acceleration : int = 240

var client_character
var movement_vector : Vector2
var player_state

func _ready():
	set_physics_process(false)

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
		stat_movement_speed_current = 0
	else:
		#stat_movement_speed_current += stat_movement_speed_acceleration * delta
		stat_movement_speed_current = 100
		if stat_movement_speed_current > stat_movement_speed_maximum:
			stat_movement_speed_current = stat_movement_speed_maximum
	
	if movement_vector:
		velocity = movement_vector * stat_movement_speed_current
	else:
		velocity = movement_vector
	
	move_and_slide()
