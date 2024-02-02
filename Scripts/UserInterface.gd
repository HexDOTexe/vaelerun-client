extends Node

@onready var debug_display = preload("res://Scenes/ClientDisplay.tscn")
@onready var login_menu = preload("res://Scenes/Interface/LoginMenu.tscn")
@onready var tooltip = preload("res://Scenes/Interface/Tooltip.tscn")

var hovered_target
var selected_target
var focused_target

var tooltip_active : bool = false

func _ready():
	start_canvas()

func _process(_delta):
	if tooltip_active == true:
		$GUI/Tooltip.global_position = get_viewport().get_mouse_position()
	if hovered_target:
		display_tooltip()
	else:
		erase_tooltip()

func start_canvas():
	var new_canvas = CanvasLayer.new()
	var new_debug_display = debug_display.instantiate()
	new_canvas.name = "GUI"
	add_child(new_canvas)
	$GUI.add_child(new_debug_display)

func mouse_hover(target):
	if hovered_target == null:
		hovered_target = target

func mouse_dehover(_target):
	if !hovered_target == null:
		hovered_target = null

func display_tooltip():
	if tooltip_active == false:
		var new_tooltip = tooltip.instantiate()
		if hovered_target.entity_type == "Player":
			new_tooltip.content += str(hovered_target.entity_name) + "\n"
			new_tooltip.content += "Level "+str(hovered_target.entity_level)+" "+str(hovered_target.entity_class)+"\n"
			new_tooltip.global_position = get_viewport().get_mouse_position()
			$GUI.add_child(new_tooltip)
			tooltip_active = true
			#print(hovered_target.entity_name)
		if hovered_target.entity_type == "NPC":
			new_tooltip.content += str(hovered_target.entity_name) + "\n"
			new_tooltip.content += "Level "+str(hovered_target.entity_level)+" "+str(hovered_target.entity_class)+"\n"
			new_tooltip.global_position = get_viewport().get_mouse_position()
			$GUI.add_child(new_tooltip)
			tooltip_active = true
			#print(hovered_target.entity_name)

func erase_tooltip():
	if tooltip_active == true:
		$GUI/Tooltip.free()
		tooltip_active = false
