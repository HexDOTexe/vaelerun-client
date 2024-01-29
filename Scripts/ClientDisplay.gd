extends Node

var world_time

func _process(_delta):
	if Server.connection_status == 1:
		$ClientStatus.text = ""
		$ClientStatus.text += str(Engine.get_frames_per_second()) + "fps" + "\n"
		$ClientStatus.text += str(int(Server.latency)) + "ms" + "\n"
		$ClientStatus.text += "last server time: " + str(world_time) + "\n"
		$ClientStatus.text += "adjusted time:    " + str(Server.adjusted_clock) + "\n"

func get_world_time(time):
	world_time = time
