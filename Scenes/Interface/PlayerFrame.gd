extends Control

var character_name = Server.temp_name

func _ready():
	update_name_label()

func _physics_process(_delta):
	refresh_elements()

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("player frame")

func refresh_elements():
	update_name_label()

func update_name_label():
	character_name = Server.temp_name
	$FrameBorder/NameLabel.text = character_name
