extends Node

@onready var test_map = preload("res://Scenes/Maps/Test/TestMap.tscn")
@onready var player_node = preload("res://Scenes/Entities/Player.tscn")
@onready var other_player_node = preload("res://Scenes/Entities/OtherPlayer.tscn")

var world_map
var local_world_state = 0

func _ready():
	load_map()

func load_map():
	world_map = test_map.instantiate()
	world_map.name = "Map"
	world_map.visible = false
	add_child(world_map)

#region Player Events
func spawn_new_player(client_id, position):
	if multiplayer.get_unique_id() == client_id:
		var new_player = player_node.instantiate()
		new_player.position = Vector2(500,400)
		new_player.name = str(client_id)
		$Map.add_child(new_player)
	else:
		var new_player = other_player_node.instantiate()
		new_player.position = Vector2(500,400)
		new_player.name = str(client_id)
		$Map.add_child(new_player)

func update_player(client_id, position):
	pass

func despawn_player(client_id):
	get_node("./Map/" + str(client_id)).queue_free()
#endregion

func update_world_state(world_state):
	if world_state["T"] > local_world_state:
		local_world_state = world_state["T"]
		world_state.erase("T")
		world_state.erase(multiplayer.get_unique_id())
		for player in world_state.keys():
			if $Map.has_node(str(player)):
				get_node("./Map/" + str(player)).update_player(world_state[player]["P"])
			else:
				print("Spawning new player")
				spawn_new_player(player, world_state[player]["P"])
	#print("new world state received")
