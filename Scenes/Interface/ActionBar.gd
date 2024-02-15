extends Control

@onready var Bar1 = $Panel/VDIV/ActionBar1
@onready var Bar2 = $Panel/VDIV/ActionBar2
@onready var Bar3 = $Panel/VDIV/ActionBar3

var bars_locked : bool = false
var active_rows : int = 1

func _process(delta):
	match active_rows:
		1:
			if Bar2.visible == true:
				Bar2.visible = false
			if Bar3.visible == true:
				Bar3.visible = false
		2:
			if Bar2.visible == false:
				Bar2.visible = true
			if Bar3.visible == true:
				Bar3.visible = false
		3:
			if Bar2.visible == false:
				Bar2.visible = true
			if Bar3.visible == false:
				Bar3.visible = true

func _on_expand_button_pressed():
	if active_rows <= 2:
		active_rows += 1

func _on_collapse_button_pressed():
	if active_rows > 0:
		active_rows -= 1
