extends Control

@onready var label = $BGPanel/MarginContainer/RichTextLabel

var content : String = ""

func _ready():
	pass

func display_content(data):
	if data.entity_type == "Player":
		content = ""
		content += str(data.entity_name) + "\n"
		content += "Level "+str(data.entity_level)+" "+str(data.entity_class)+"\n"
	if data.entity_type == "NPC":
		content = ""
		content += str(data.entity_name) + "\n"
		content += "Level "+str(data.entity_level)+" "+str(data.entity_class)+"\n"
	label.text = str(content)
