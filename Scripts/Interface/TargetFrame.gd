extends Control
# TARGET FRAME

var map = "root/SceneManager/World/Map"
var frame_active : bool = false

var target
var target_name
var health_maximum
var health_current
var health_percent
var power_maximum
var power_current
var power_percent


func _ready():
	pass

func _physics_process(_delta):
	if UserInterface.selected_target:
		if !target == UserInterface.selected_target:
			target = get_tree().get_nodes_in_group("target")[0]
			target_name = target.entity_name
		refresh_elements()
		self.visible = true
		frame_active = true
	else:
		self.visible = false
		frame_active = false

func _on_frame_border_gui_input(event):
	pass # Replace with function body.

func _on_frame_border_mouse_entered():
	UserInterface.mouse_hover(target.name)

func _on_frame_border_mouse_exited():
	UserInterface.mouse_dehover(target.name)

func refresh_elements():
	if UserInterface.overlay_active == true:
		update_name()
		update_health()
		update_power()

func update_name():
	$Name/NameLabel.text = target_name

func update_health():
	health_maximum = target.health_maximum
	health_current = target.health_current
	health_percent = target.health_percent
	$Health/Bar.value = health_current
	$Health/Bar/ValueLabel.text = str(health_current)+" / "+str(health_maximum)

func update_power():
	power_maximum = target.power_maximum
	power_current = target.power_current
	power_percent = target.power_percent
	$Power/Bar.value = power_current
	$Power/Bar/ValueLabel.text = str(power_current)+" / "+str(power_maximum)
