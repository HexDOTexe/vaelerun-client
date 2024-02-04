extends Camera2D

var camera_zoom_max = Vector2(1.0, 1.0)
var camera_zoom_min = Vector2(5.0, 5.0)
var camera_zoom_current = Vector2(1.5, 1.5)
var camera_zoom_previous : Vector2

func _process(_delta):
	camera_move()

func camera_move():
	if Input.is_action_just_pressed("camera_zoom_in"):
		camera_zoom_previous = camera_zoom_current
		camera_zoom_current += Vector2(0.10, 0.10)
		print("Zooming in")
	if Input.is_action_just_pressed("camera_zoom_out"):
		camera_zoom_previous = camera_zoom_current
		camera_zoom_current -= Vector2(0.10, 0.10)
		print("Zooming out")
	
	if camera_zoom_current > camera_zoom_min:
		camera_zoom_current = camera_zoom_min
		print("Min zoom limit reached")
	if camera_zoom_current < camera_zoom_max:
		camera_zoom_current = camera_zoom_max
		print("Max zoom limit reached")
	
	if camera_zoom_previous != camera_zoom_current:
		var tween = create_tween()
		tween.tween_property(self, "zoom", camera_zoom_current,  0.1)
