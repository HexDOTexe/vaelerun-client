extends Control

enum TooltipTypes {PLAYER, OTHER_PLAYER, NPC, PROP}

@export var tooltip_type : TooltipTypes

func _physics_process(delta):
	refresh_tooltip_content()

#func refresh_tooltip_content():
	#if tooltip_type == TooltipTypes.PLAYER_SELF:
		#var content = ""
		#content += "[color=green][b]"+get_parent().entity_name+"[/b][/color]" + "\n"
		#content += "Level "+str(get_parent().entity_level)+" "+str(get_parent().entity_class)+"\n"
		#tooltip_text = content
	#elif tooltip_type == TooltipTypes.PLAYER_OTHER:
		#var content = ""
		#content += "[color=yellow][b]"+get_parent().entity_name+"[/b][/color]" + "\n"
		#content += "Level "+str(get_parent().entity_level)+" "+str(get_parent().entity_class)+"\n"
		#tooltip_text = content  
	#elif tooltip_type == TooltipTypes.NPC:
		#var content = ""
		#content += "[color=red][b]"+get_parent().entity_name+"[/b][/color]" + "\n"
		#content += "Level "+str(get_parent().entity_level)+" "+str(get_parent().entity_class)+"\n"
		#tooltip_text = content  

func refresh_tooltip_content():
	var type = get_parent().entity_type
	match type:
		TooltipTypes.PLAYER:
			var content = ""
			content += "[color=green][b]"+get_parent().entity_name+"[/b][/color]" + "\n"
			content += "Level "+str(get_parent().entity_level)+" "+str(get_parent().entity_class)+"\n"
			tooltip_text = content
		TooltipTypes.OTHER_PLAYER:
			var content = ""
			content += "[color=yellow][b]"+get_parent().entity_name+"[/b][/color]" + "\n"
			content += "Level "+str(get_parent().entity_level)+" "+str(get_parent().entity_class)+"\n"
			tooltip_text = content  
		TooltipTypes.NPC:
			var content = ""
			content += "[color=red][b]"+get_parent().entity_name+"[/b][/color]" + "\n"
			content += "Level "+str(get_parent().entity_level)+" "+str(get_parent().entity_class)+"\n"
			tooltip_text = content 
		
