extends Control
# PLAYER FRAME

var player
var player_name = Server.temp_name
var player_sprite
var health_maximum
var health_current
var health_percent
var power_maximum
var power_current
var power_percent


func _ready():
	pass

func _physics_process(_delta):
	if UserInterface.overlay_active == true:
		if player:
			refresh_elements()
		else:
			player = get_tree().get_nodes_in_group("self")[0]
			player_name = player.entity_name

func _gui_input(event):
	pass

func _on_frame_border_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			UserInterface.select_target(player)
			print("player frame")

func _on_frame_border_mouse_entered():
	UserInterface.mouse_hover(player.name)

func _on_frame_border_mouse_exited():
	UserInterface.mouse_dehover(player.name)

func refresh_elements():
	if UserInterface.overlay_active == true:
		update_name()
		update_health()
		update_power()

func update_name():
	$Name/NameLabel.text = player_name

func update_health():
	health_maximum = player.health_maximum
	health_current = player.health_current
	health_percent = player.health_percent
	$Health/Bar.value = health_current
	$Health/Bar/ValueLabel.text = str(health_current)+" / "+str(health_maximum)

func update_power():
	power_maximum = player.power_maximum
	power_current = player.power_current
	power_percent = player.power_percent
	$Power/Bar.value = power_current
	$Power/Bar/ValueLabel.text = str(power_current)+" / "+str(power_maximum)



