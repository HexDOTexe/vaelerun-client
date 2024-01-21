extends Node


func _on_button_pressed():
	Server.temp_name = $TextEdit.text
	Server.connect_to_server()
