extends Node

@onready var namebox = $LoginPanel/MarginContainer/VDIV/HDIV/NameBox
@onready var connect = $LoginPanel/MarginContainer/VDIV/Connect
@onready var join = $LoginPanel/MarginContainer/VDIV/Join
@onready var message = $LoginPanel/MarginContainer/VDIV/MessageLabel


func _physics_process(delta):
	if Server.connection_status == 1:
		connect.disabled = true
		message.text = "Connected to server."
		join.disabled = false
	else:
		message.text = ""
		join.disabled = true

func _on_text_edit_text_changed():
	if namebox.text:
		Server.temp_name = namebox.text
		connect.disabled = false
	else:
		connect.disabled = true

# Connect button
func _on_connect_pressed():
	namebox.editable = false
	Server.connect_to_server()

# Join button
func _on_button_pressed():
	self.visible = false
	get_parent().get_node("World/Map").visible = true
	pass
