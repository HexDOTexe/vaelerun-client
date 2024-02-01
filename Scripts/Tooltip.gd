extends Control

@onready var label = $BGPanel/MarginContainer/RichTextLabel

var content : String = ""

func _ready():
	display_content()

func display_content():
	label.text = str(content)
