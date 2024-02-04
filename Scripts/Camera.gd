extends Camera2D

var camera_zoom_max = Vector2(1.0, 1.0)
var camera_zoom_min = Vector2(5.0, 5.0)
var camera_zoom_current = Vector2(1.5, 1.5)
var camera_zoom_previous : Vector2

func _process(_delta):
	camera_update()

func activate_camera():
	self.enabled = true
	self.visible = true

func camera_update():
	if Input.is_action_just_pressed("camera_zoom_in"):
		camera_zoom_previous = camera_zoom_current
		camera_zoom_current += Vector2(0.10, 0.10)
	if Input.is_action_just_pressed("camera_zoom_out"):
		camera_zoom_previous = camera_zoom_current
		camera_zoom_current -= Vector2(0.10, 0.10)
	
	if camera_zoom_current > camera_zoom_min:
		camera_zoom_current = camera_zoom_min
	if camera_zoom_current < camera_zoom_max:
		camera_zoom_current = camera_zoom_max
	
	if camera_zoom_previous != camera_zoom_current:
		var tween = create_tween()
		tween.tween_property(self, "zoom", camera_zoom_current,  0.1)
