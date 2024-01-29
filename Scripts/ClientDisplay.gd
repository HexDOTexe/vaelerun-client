extends Node

func _process(_delta):
	$ClientStatus.text = str(int(Server.latency))
