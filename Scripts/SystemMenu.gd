extends Control

@onready var ResolutionOptions = $TabContainer/Video/Margin/Grid/ResolutionOptions
@onready var DisplayOptions = $TabContainer/Video/Margin/Grid/DisplayOptions
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
	pass # Replace with function body.

func _on_display_options_item_selected(index):
	pass # Replace with function body.

func _on_vsync_check_box_toggled(toggled_on):
	if toggled_on == true:
		Settings.vsync_enabled = true
	else:
		Settings.vsync_enabled = false

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









