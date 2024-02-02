extends Node

@onready var debug_display = preload("res://Scenes/ClientDisplay.tscn")
@onready var login_menu = preload("res://Scenes/Interface/LoginMenu.tscn")
@onready var tooltip = preload("res://Scenes/Interface/Tooltip.tscn")

var hovered_targets = []
var selected_target
var focused_target

var tooltip_active : bool = false

func _ready():
	start_canvas()

func _process(_delta):
	if tooltip_active == true:
		$GUI/Tooltip.global_position = get_viewport().get_mouse_position()
	if hovered_targets.is_empty() == false:
		display_tooltip()
	else:
		hide_tooltip()

func start_canvas():
	var new_canvas = CanvasLayer.new()
	var new_debug_display = debug_display.instantiate()
	var new_tooltip = tooltip.instantiate()
	new_canvas.name = "GUI"
	new_tooltip.visible = false
	add_child(new_canvas)
	$GUI.add_child(new_debug_display)
	$GUI.add_child(new_tooltip)

func mouse_hover(target):
	hovered_targets.append(target)

func mouse_dehover(target):
	hovered_targets.erase(target)

func display_tooltip():
	var data = hovered_targets[0]
	$GUI/Tooltip.display_content(data)
	$GUI/Tooltip.visible = true
	tooltip_active = true

func hide_tooltip():
	if tooltip_active == true:
		$GUI/Tooltip.visible = false
		tooltip_active = false
