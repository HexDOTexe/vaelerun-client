extends Control

enum NameplateTypes {PLAYER, OTHER_PLAYER, NPC, PROP}

@onready var plate_position = str(get_parent().get_global_transform_with_canvas().origin)
@export var nameplate : RichTextLabel

func _ready():
	pass

func _process(delta):
	if UserInterface.overlay_active == true:
		$Canvas.visible = true
	else:
		$Canvas.visible = false
	set_nameplate()

func _physics_process(_delta):
	pass

func set_nameplate():
	if Settings.nameplates_show_all == true:
		var type = get_parent().entity_type
		nameplate.position =  get_global_transform_with_canvas().origin
		match type:
			NameplateTypes.PLAYER:
				if Settings.nameplates_show_self == true:
					var content = ""
					content += "[color=green][b]"+get_parent().entity_name+"[/b][/color]" + "\n"
					nameplate.text = content
				else:
					nameplate.text = ""
			NameplateTypes.OTHER_PLAYER:
				var content = ""
				content += "[color=yellow][b]"+get_parent().entity_name+"[/b][/color]" + "\n"
				nameplate.text = content
			NameplateTypes.NPC:
				var content = ""
				content += "[color=red][b]"+get_parent().entity_name+"[/b][/color]" + "\n"
				nameplate.text = content
	else:
		nameplate.text = ""
