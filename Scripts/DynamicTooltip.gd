extends Control

@onready var label = $BGPanel/MarginContainer/RichTextLabel

var content : String = ""

func _ready():
	pass

func _process(_delta):
	if UserInterface.tooltip_follows_cursor == true:
		self.global_position = get_viewport().get_mouse_position()

func display_content(data):
	content = get_node("/root/SceneManager/World/Map/"+data+"/TooltipData").get_tooltip()
	label.text = content
