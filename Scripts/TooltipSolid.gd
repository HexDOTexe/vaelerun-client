extends Control

@onready var label = $BGPanel/MarginContainer/RichTextLabel

var content : String = ""

func _ready():
	print("ready")
	pass

func _process(_delta):
	if UserInterface.tooltip_follows_cursor == true:
		self.global_position = get_viewport().get_mouse_position()
