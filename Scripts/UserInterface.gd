extends Node

@onready var debug_display = preload("res://Scenes/ClientDisplay.tscn")
@onready var LoginMenu = preload("res://Scenes/Interface/LoginMenu.tscn")
@onready var Overlay = preload("res://Scenes/Interface/Overlay.tscn")
@onready var GameMenu = preload("res://Scenes/Interface/GameMenu.tscn")
@onready var SystemMenu = preload("res://Scenes/Interface/SystemMenu.tscn")
@onready var DynamicTooltip = preload("res://Scenes/Interface/DynamicTooltip.tscn")

var active_menus = []
var hovered_targets = []
var selected_target
var focused_target
var tooltip_active : bool = false

# USER SETTINGS
var tooltip_follows_cursor : bool = true
var tooltip_delay : float = 0.1
var nameplates_show_all : bool = true
var nameplates_show_self : bool = true

func _ready():
	start_canvas()

func _process(_delta):
	if hovered_targets.is_empty() == false:
		display_tooltip()
	else:
		hide_tooltip()

func _physics_process(delta):
	pass

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel"):
			if active_menus.is_empty() == true:
				open_specific_menu(GameMenu)
			else:
				var last_menu = active_menus.size() - 1
				close_specific_menu(active_menus[last_menu])

func start_canvas():
	var new_canvas = CanvasLayer.new()
	var new_debug_display = debug_display.instantiate()
	var new_dynamic_tooltip = DynamicTooltip.instantiate()
	var new_overlay = Overlay.instantiate()
	new_canvas.name = "GUI"
	new_overlay.visible = false
	new_dynamic_tooltip.visible = false
	add_child(new_canvas)
	$GUI.add_child(new_debug_display)
	$GUI.add_child(new_dynamic_tooltip)
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
	var data = hovered_targets.back()
	$GUI/DynamicTooltip.display_content(data)
	await get_tree().create_timer(tooltip_delay).timeout
	$GUI/DynamicTooltip.visible = true

func hide_tooltip():
	$GUI/DynamicTooltip.visible = false
	tooltip_active = false

func open_specific_menu(menu):
	var new_menu = menu.instantiate()
	$GUI.add_child(new_menu)
	print("Opening menu: " + str(new_menu.name))
	active_menus.append(str(new_menu.name))

func close_specific_menu(menu):
	var menu_obj = $GUI.get_node(menu)
	$GUI.remove_child(menu_obj)
	print("Closing menu: "+menu)
	active_menus.erase(menu)

func quit_to_title():
	pass
