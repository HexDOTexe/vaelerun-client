extends Control

@onready var label = $BGPanel/MarginContainer/RichTextLabel

var content : String = ""

func _ready():
	pass

func display_content(data):
	content = get_node("/root/SceneManager/World/Map/"+data).get_tooltip()
	label.text = content
