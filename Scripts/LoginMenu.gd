extends Node

@onready var namebox = $LoginPanel/MarginContainer/VDIV/HDIV/NameBox
@onready var connect_button = $LoginPanel/MarginContainer/VDIV/Connect
@onready var join_button = $LoginPanel/MarginContainer/VDIV/Join
@onready var message_box = $LoginPanel/MarginContainer/VDIV/MessageLabel


func _physics_process(_delta):
	if Server.connection_status == 1:
		connect_button.disabled = true
		message_box.text = "Connected to server."
		join_button.disabled = false
	else:
		message_box.text = ""
		join_button.disabled = true

func _on_text_edit_text_changed():
	if namebox.text:
		Server.temp_name = namebox.text
		connect_button.disabled = false
	else:
		connect_button.disabled = true

# Connect button
func _on_connect_pressed():
	namebox.editable = false
	Server.connect_to_server()
	

# Join button
func _on_button_pressed():
	self.visible = false
	get_parent().get_node("World/Map").visible = true
	get_parent().get_node("World/Map/"+str(Server.local_client_id)).activate_camera()
	UserInterface.display_overlay()
