extends RichTextLabel

func _ready():
	set_nameplate()

func _physics_process(delta):
	set_nameplate()

func set_nameplate():
	self.text = get_parent().entity_name
