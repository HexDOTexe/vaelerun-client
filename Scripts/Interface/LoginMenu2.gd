extends Node

@onready var namebox = $LoginPanel/MarginContainer/VDIV/HDIV/NameBox
@onready var connect_button = $LoginPanel/MarginContainer/VDIV/ConnectButton
@onready var message_box = $LoginPanel/MarginContainer/VDIV/MessageLabel

@export var CreateUserWindow : PackedScene

signal LoginUser(user, password)
signal CreateUser(user, password)

func _physics_process(_delta):
	pass

func _on_name_box_text_changed(_new_text):
	pass

func _on_connect_button_pressed():
	LoginUser.emit($LoginPanel/MarginContainer/VDIV/HDIV/NameBox.text, $LoginPanel/MarginContainer/VDIV/HDIV2/PasswordBox.text)
	pass

func _on_new_user_button_pressed():
	var create_user_window = CreateUserWindow.instantiate()
	add_child(create_user_window)
	#create_user_window.CreateUser.connect()
	pass # Replace with function body.

func createUser(name, password):
	CreateUser.emit(name, password)

func _on_exit_button_pressed():
	if Server.connection_status == 1:
		get_tree().quit()
	else:
		get_tree().quit()






