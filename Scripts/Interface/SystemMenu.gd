extends Control

@onready var DisplayOptions = $TabContainer/Video/Margin/Grid/DisplayOptions
@onready var ResolutionOptions = $TabContainer/Video/Margin/Grid/ResolutionOptions
@onready var VsyncCheckBox = $TabContainer/Video/Margin/Grid/VsyncCheckBox
@onready var FrameLimitCheckBox = $TabContainer/Video/Margin/Grid/FrameLimitCheckBox
@onready var SoundEnabledCheckBox = $TabContainer/Audio/Margin/VDIV/Grid/SoundEnabledCheckBox
@onready var NameplatesCheckBox = $TabContainer/Interface/Margin/Grid/NameplatesCheckBox
@onready var SelfNameplateCheckBox = $TabContainer/Interface/Margin/Grid/SelfNameplateCheckBox
@onready var TooltipOnCursorCheckBox = $TabContainer/Interface/Margin/Grid/TooltipOnCursorCheckBox





func _ready():
	check_settings()

func check_settings():
	# update menu so that it displays selections accurate to loaded or default settings
	# Video
	if Settings.display_mode == Settings.DisplayModes.FULLSCREEN:
		DisplayOptions.selected = 0
	elif Settings.display_mode == Settings.DisplayModes.WINDOWED:
		DisplayOptions.selected = 1
	VsyncCheckBox.button_pressed = Settings.vsync_enabled
	FrameLimitCheckBox.button_pressed = Settings.frame_limit_enabled
	# Sound
	SoundEnabledCheckBox.button_pressed = Settings.sound_enabled
	# Interface
	NameplatesCheckBox.button_pressed = Settings.nameplates_show_all
	SelfNameplateCheckBox.button_pressed = Settings.nameplates_show_self
	TooltipOnCursorCheckBox.button_pressed = Settings.tooltip_follows_cursor

#region VIDEO OPTIONS
func _on_resolution_options_item_selected(index):
	match index:
		0:
			Settings.base_window_size = Vector2(2560, 1440)
			print("change resolution to 2560 x 1440")
		1:
			Settings.base_window_size = Vector2(1920, 1080)
			print("change resolution to 1920 x 1080")
		2:
			Settings.base_window_size = Vector2(1280, 720)
			print("change resolution to 1280 x 720")

func _on_display_options_item_selected(index):
	match index:
		0:	# Fullscreen
			Settings.display_mode = Settings.DisplayModes.FULLSCREEN
			if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
				print("change display mode to fullscreen")
		1:	# Windowed
			Settings.display_mode = Settings.DisplayModes.WINDOWED
			if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				print("change display mode to windowed")

func _on_vsync_check_box_toggled(toggled_on):
	if toggled_on == true:
		Settings.vsync_enabled = true
		print("change vsync to enabled")
	else:
		Settings.vsync_enabled = false
		print("change vsync to disabled")

func _on_frame_limit_check_box_toggled(toggled_on):
	if toggled_on == true:
		Settings.frame_limit_enabled = true
	else:
		Settings.frame_limit_enabled = false
#endregion

#region AUDIO OPTIONS
func _on_sound_enabled_check_box_toggled(toggled_on):
	if toggled_on == true:
		Settings.sound_enabled = true
	else:
		Settings.sound_enabled = false
#endregion

#region INTERFACE OPTIONS
func _on_nameplates_check_box_toggled(toggled_on):
	if toggled_on == true:
		Settings.nameplates_show_all = true
	else:
		Settings.nameplates_show_all = false

func _on_self_nameplate_check_box_toggled(toggled_on):
	if toggled_on == true:
		Settings.nameplates_show_self = true
	else:
		Settings.nameplates_show_self = false

func _on_tooltip_on_cursor_check_box_toggled(toggled_on):
	if toggled_on == true:
		Settings.tooltip_follows_cursor = true
	else:
		Settings.tooltip_follows_cursor = false
#endregion









