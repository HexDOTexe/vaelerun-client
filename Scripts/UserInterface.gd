extends Node

@onready var debug_display = preload("res://Scenes/ClientDisplay.tscn")
@onready var login_menu = preload("res://Scenes/Interface/LoginMenu.tscn")
@onready var overlay = preload("res://Scenes/Interface/Overlay.tscn")
@onready var tooltip = preload("res://Scenes/Interface/Tooltip.tscn")

var hovered_targets = []
var selected_target
var focused_target

var tooltip_active : bool = false
var tooltip_follows_cursor : bool = true

func _ready():
	start_canvas()

func _process(_delta):
	if tooltip_follows_cursor == true:
		$GUI/Tooltip.global_position = get_viewport().get_mouse_position()
	if hovered_targets.is_empty() == false:
		display_tooltip()
	else:
		hide_tooltip()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if hovered_targets.is_empty() == false:
				selected_target = hovered_targets[0] 
				print(str(selected_target.entity_name))
				#print("Mouse Click at: ", event.position)

func start_canvas():
	var new_canvas = CanvasLayer.new()
	var new_debug_display = debug_display.instantiate()
	var new_tooltip = tooltip.instantiate()
	var new_overlay = overlay.instantiate()
	new_canvas.name = "GUI"
	new_overlay.visible = false
	new_tooltip.visible = false
	add_child(new_canvas)
	$GUI.add_child(new_debug_display)
	$GUI.add_child(new_tooltip)
	$GUI.add_child(new_overlay)

func mouse_hover(target):
	hovered_targets.append(target)

func mouse_dehover(target):
	hovered_targets.erase(target)

func select_hovered_target():
	pass

func deselect_target():
	pass

func display_overlay():
	$GUI/Overlay.visible = true

func hide_overlay():
	$GUI/Overlay.visible = false

func display_tooltip():
	if hovered_targets.is_empty() == false:
		var data = hovered_targets[0]
		$GUI/Tooltip.display_content(data)
		$GUI/Tooltip.visible = true
		tooltip_active = true

func hide_tooltip():
	if tooltip_active == true:
		$GUI/Tooltip.visible = false
		tooltip_active = false
