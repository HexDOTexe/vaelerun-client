extends Node

@onready var namebox = $LoginPanel/MarginContainer/VDIV/HDIV/NameBox
@onready var connect_button = $LoginPanel/MarginContainer/VDIV/ConnectButton
@onready var join_button = $LoginPanel/MarginContainer/VDIV/JoinButton
@onready var message_box = $LoginPanel/MarginContainer/VDIV/MessageLabel


func _physics_process(_delta):
	if Server.connection_status == 1:
		connect_button.disabled = true
		message_box.text = "Connected to server."
		join_button.disabled = false
	else:
		message_box.text = ""
		join_button.disabled = true

# Name box
func _on_name_box_text_changed(_new_text):
	# Checks contents of the login name field and does 2 things:
	# 1 - Formats player name appropriately, 0=[UPPER], 1>=[lower]
	# 2 - Disables or enables the Connect button based on name contents
	if namebox.text:
		var caret_pos = namebox.caret_column
		var format = namebox.text
		format[0] = format[0].to_upper()
		for character in format.length():
			if character > 0:
				format[character] = format[character].to_lower()
		namebox.text = format
		namebox.caret_column = caret_pos
		Server.temp_name = namebox.text
		if format.length() > 4:
			connect_button.disabled = false
	else:
		connect_button.disabled = true

func _on_connect_button_pressed():
	namebox.editable = false
	Server.connect_to_server()

func _on_join_button_pressed():
	self.visible = false
	get_parent().get_node("World/Map").visible = true
	get_parent().get_node("World/Map/"+str(Server.local_client_id)).activate_camera()
	UserInterface.display_overlay()

func _on_exit_button_pressed():
	if Server.connection_status == 1:
		get_tree().quit()
	else:
		get_tree().quit()
