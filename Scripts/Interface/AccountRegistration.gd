extends PanelContainer

signal CreateUser(user, password)

func _on_submit_button_pressed():
	CreateUser.emit($MarginContainer/VDIV/HDIV/NewNameBox.text, $MarginContainer/VDIV/HDIV2/NewPasswordBox.text)
	pass # Replace with function body.

func _on_close_button_pressed():
	queue_free()
	pass # Replace with function body.
