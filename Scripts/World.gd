extends Node

@onready var test_map = preload("res://Scenes/Maps/Test/TestMap.tscn")
@onready var player_node = preload("res://Scenes/Entities/Player.tscn")
@onready var other_player_node = preload("res://Scenes/Entities/OtherPlayer.tscn")

var world_map

var local_world_state = 0
var world_state_buffer = []
const interpolation_rate = 0.100

func _ready():
	load_map()

func _physics_process(delta):
	process_world_state_buffer(delta)
	pass

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
		if !$Map.has_node(str(client_id)):
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
		world_state_buffer.append(world_state)

func process_world_state_buffer(delta):
	var render_time = Time.get_unix_time_from_system() - interpolation_rate
	if world_state_buffer.size() > 1:
		while world_state_buffer.size() > 2 and render_time > world_state_buffer[1]["T"]:
			world_state_buffer.remove_at(0)
		var interpolation_factor = float(render_time - world_state_buffer[0]["T"]) / float(world_state_buffer[1]["T"] - world_state_buffer[0]["T"])
		for player in world_state_buffer[1].keys():
			if str(player) == "T":
				continue
			if player == multiplayer.get_unique_id():
				continue
			if !world_state_buffer[0].has(player):
				continue
			if $Map.has_node(str(player)):
				var new_position = lerp(world_state_buffer[0][player]["P"], world_state_buffer[1][player]["P"], interpolation_factor)
				get_node("./Map/" + str(player)).update_player(new_position)
			else:
				print("Spawning new player")
				spawn_new_player(player, world_state_buffer[1][player]["P"])

# Don't use this! This is the NON-BUFFERED version of the world state update process. 
# Player updates are processed in real-time as packets are receved (looks/feels bad)
# Keeping this here mostly as a reminder as to how the 
func OLDupdate_world_state(world_state):
	if world_state["T"] > local_world_state:
		local_world_state = world_state["T"]
		world_state.erase(multiplayer.get_unique_id())
		for player in world_state.keys():
			if $Map.has_node(str(player)):
				get_node("./Map/" + str(player)).update_player(world_state[player]["P"])
			else:
				print("Spawning new player")
				spawn_new_player(player, world_state[player]["P"])
