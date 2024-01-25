extends Node

func _physics_process(delta):
	if Server.connection_status == 1:
		$Connect.disabled = true
		$MessageLabel.text = "Connected to server."
		$Join.disabled = false
	else:
		$MessageLabel.text = ""
		$Join.disabled = true

func _on_text_edit_text_changed():
	if $NameBox.text:
		Server.temp_name = $NameBox.text
		$Connect.disabled = false
	else:
		$Connect.disabled = true

# Connect button
func _on_connect_pressed():
	$NameBox.editable = false
	Server.connect_to_server()

# Join button
func _on_button_pressed():
	self.visible = false
	get_parent().get_node("World/Map").visible = true
	pass
