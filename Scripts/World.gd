extends Node

@onready var test_map = preload("res://Scenes/Maps/Test/TestMap.tscn")
@onready var player_node = preload("res://Scenes/Entities/Player.tscn")
@onready var other_player_node = preload("res://Scenes/Entities/OtherPlayer.tscn")

var world_map

func _ready():
	load_map()

func load_map():
	world_map = test_map.instantiate()
	world_map.name = "Map"
	world_map.visible = false
	add_child(world_map)

func spawn_new_player(client_id, position):
	if multiplayer.get_unique_id() == client_id:
		var new_player = player_node.instantiate()
		new_player.position = Vector2(100,100)
		new_player.name = str(client_id)
		$Map.add_child(new_player)
	else:
		var new_player = other_player_node.instantiate()
		new_player.position = Vector2(100,100)
		new_player.name = str(client_id)
		$Map.add_child(new_player)

func despawn_new_player(client_id):
	get_node(str(client_id)).queue_free()
