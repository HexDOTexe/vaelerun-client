extends Control

var character_name = Server.temp_name
var health_maximum
var health_current
var health_percent
var power_maximum
var power_current
var power_percent


func _ready():
	update_name()

func _physics_process(_delta):
	refresh_elements()

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("player frame")

func _on_frame_border_gui_input(event):
	pass # Replace with function body.

func _on_frame_border_mouse_entered():
	UserInterface.mouse_hover(Server.local_client_id)

func _on_frame_border_mouse_exited():
	UserInterface.mouse_dehover(Server.local_client_id)

func refresh_elements():
	if UserInterface.overlay_active == true:
		update_name()
		update_health()
		update_power()

func update_name():
	character_name = Server.temp_name
	$Name/NameLabel.text = character_name

func update_health():
	var client = str(Server.local_client_id)
	var character = get_tree().get_nodes_in_group("self")[0]
	health_maximum = character.health_maximum
	health_current = character.health_current
	health_percent = character.health_percent
	$Health/Bar.value = health_current
	$Health/Bar/ValueLabel.text = str(health_current)+" / "+str(health_maximum)

func update_power():
	var client = str(Server.local_client_id)
	var character = get_tree().get_nodes_in_group("self")[0]
	power_maximum = character.power_maximum
	power_current = character.power_current
	power_percent = character.power_percent
	$Power/Bar.value = power_current
	$Power/Bar/ValueLabel.text = str(power_current)+" / "+str(power_maximum)
