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

func despawn_player(client_id):
	get_node("./Map/" + str(client_id)).queue_free()
#endregion

func update_world_state(world_state):
	if world_state["T"] > local_world_state:
		local_world_state = world_state["T"]
		world_state_buffer.append(world_state)

func process_world_state_buffer(_delta):
	# Server updates are intentionally slightly behind t=0 in order to reduce the need for perfect network communication
	# 0:[Old State] - 1:[Previous State] - 2:[Next State] - 3:[Future State]
	# if buffersize > 2, we have received enough updates to smoothly divide the states of the world updates
	# otherwise, we will instead make some estimations based on previous states
	# currently the estimation method gives an error if running the game from the editor, but seems fine with the standalone binary?
	var render_time = Server.adjusted_clock - interpolation_rate
	if world_state_buffer.size() > 1:
		while world_state_buffer.size() > 2 and render_time > world_state_buffer[2]["T"]:
			world_state_buffer.remove_at(0)
		if world_state_buffer.size() > 2:
			var interpolation_factor = float(render_time - world_state_buffer[1]["T"]) / float(world_state_buffer[2]["T"] - world_state_buffer[1]["T"])
			for player in world_state_buffer[2].keys():
				if str(player) == "T":
					continue
				if player == multiplayer.get_unique_id():
					continue
				if !world_state_buffer[1].has(player):
					continue
				if $Map.has_node(str(player)):
					var new_position = lerp(world_state_buffer[1][player]["P"], world_state_buffer[2][player]["P"], interpolation_factor)
					get_node("./Map/" + str(player)).update_player(new_position)
				else:
					print("Spawning new player")
					spawn_new_player(player, world_state_buffer[2][player]["P"])
		elif render_time > world_state_buffer[1]["T"]:
			var estimation_factor = float(render_time - world_state_buffer[0]["T"]) / float(world_state_buffer[1]["T"] - world_state_buffer[0]["T"]) - 1.00
			for player in world_state_buffer[1].keys():
				if str(player) == "T":
					continue
				if player == multiplayer.get_unique_id():
					continue
				if !world_state_buffer[0].has(player):
					continue
				if $Map.has_node(str(player)):
					var position_delta = (world_state_buffer[1][player]["P"] - world_state_buffer[0][player]["P"])
					var new_position = world_state_buffer[1][player]["P"] + (position_delta * estimation_factor)
					get_node("./Map/" + str(player)).update_player(new_position)

# Don't use this! This is the NON-BUFFERED version of the world state update process. 
# Player updates are processed in real-time as packets are receved (looks/feels bad)
# Keeping this here mostly as a reminder as to how the pre-buffer code works.
func OLD_update_world_state(world_state):
	if world_state["T"] > local_world_state:
		local_world_state = world_state["T"]
		world_state.erase(multiplayer.get_unique_id())
		for player in world_state.keys():
			if $Map.has_node(str(player)):
				get_node("./Map/" + str(player)).update_player(world_state[player]["P"])
			else:
				print("Spawning new player")
				spawn_new_player(player, world_state[player]["P"])
