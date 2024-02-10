extends Control

enum DisplayModes {FULLSCREEN, WINDOWED}

# USER PROPERTIES
#region Video Settings
var base_window_size : Vector2 = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height")
)
var display_mode : DisplayModes = DisplayModes.WINDOWED
var display_aspect_stretch = Window.CONTENT_SCALE_ASPECT_EXPAND
var display_stretch_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
var display_scale_mode : float = 1.0
var vsync_enabled : bool = true
var frame_limit_enabled : bool = false

#region Audio Settings
var sound_enabled : bool = true
var music_enabled : bool = true
var sound_volume : int = 50
var music_volume : int = 50
#endregion

#region Interface Settings
var tooltip_follows_cursor : bool = true
var tooltip_delay : float = 0.1
var nameplates_show_all : bool = true
var nameplates_show_self : bool = true
# endregion

func update_display():
	pass
