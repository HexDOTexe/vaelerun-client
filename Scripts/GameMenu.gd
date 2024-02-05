extends Control


func _on_system_button_pressed():
	UserInterface.open_specific_menu(UserInterface.SystemMenu)
	UserInterface.close_specific_menu("GameMenu")

func _on_controls_button_pressed():
	pass # Replace with function body.


func _on_logout_button_pressed():
	pass # Replace with function body.


func _on_exit_button_pressed():
	if Server.connection_status == 1:
		get_tree().quit()
	else:
		get_tree().quit()

func _on_return_button_pressed():
	UserInterface.close_specific_menu("GameMenu")
