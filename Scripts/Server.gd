extends Node

var network = ENetMultiplayerPeer.new()
var ip = "127.0.0.1"
var port = 9999

var temp_name = "Player"
var local_client_id

var connection_status = 0
var connection_timer = 10.0
var adjusted_clock = 0.0
var latency = 0
var latency_delta = 0
var latency_history = []

func _ready():
	pass

func _physics_process(delta):
	# Client physics runs at a standard 60fps (~0.01667s)
	# Client attempts to self-correct the local world timer based on average latency.
	# Not entirely happy with the solution as a whole. Oh well!
	adjusted_clock += delta + (latency_delta / 1000)
	latency_delta = 0

#region Server Interface
func connect_to_server():
	network.create_client(ip, port)
	network.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(network)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	multiplayer.server_disconnected.connect(server_disconnected)
#endregion

#region Network Events
func connected_to_server():
	connection_status = 1
	local_client_id = multiplayer.get_unique_id()
	request_server_time.rpc_id(1, Time.get_unix_time_from_system())
	sync_client_information.rpc_id(1, local_client_id, temp_name)
	var latency_timer = Timer.new()
	latency_timer.wait_time = 0.5
	latency_timer.autostart = true
	latency_timer.connect("timeout", check_latency)
	add_child(latency_timer)

func timeout_monitor():
	# (NYI) Starts a timer whenever communication with the server is lost.
	# After 5s, pause the physics process to pause the game state & stop sending client updates to the server. 
	# If no server update is received after 10s, disconnect the client and kick to the login menu.
	while connection_status == 0:
		await get_tree().create_timer(connection_timer).timeout

func check_latency():
	request_latency.rpc_id(1, Time.get_unix_time_from_system())

func connection_failed():
	connection_status = 0

func server_disconnected():
	pass

@rpc("any_peer", "call_remote")
func sync_client_information(_client_id, _player):
	# Function called on the server, initiated by the client.
	# Empty function exists here to pass the RPC validation check.
	pass

@rpc("any_peer", "call_remote")
func request_server_time(_client_time):
	# Function called on the server, initiated by the client.
	# Empty function exists here to pass the RPC validation check.
	pass

@rpc("authority", "call_remote")
func receive_server_time(server_time, client_time):
	# Function called on the client, initiated by the server.
	# Empty function exists on the server to pass the RPC validation check.
	latency = (Time.get_unix_time_from_system() - client_time) * 1000
	adjusted_clock = server_time + (latency / 1000)

@rpc("any_peer", "call_remote")
func request_latency():
	# Function called on the server, initiated by the client.
	# Empty function exists here to pass the RPC validation check.
	pass

@rpc("authority", "call_remote")
func receive_latency(client_time):
	# Function called on the client, initiated by the server.
	# Empty function exists on the server to pass the RPC validation check.
	latency = (Time.get_unix_time_from_system() - client_time) * 1000
	latency_history.append(latency)
	if latency_history.size() == 9:
		var latency_total = 0
		latency_history.sort()
		var median = latency_history[4]
		for i in range(latency_history.size()-1,-1,-1):
			if latency_history[i] > (2 * median) and latency_history[i] > 20:
				latency_history.remove_at(i)
			else:
				latency_total += latency_history[i]
		latency_delta = (latency_total / latency_history.size()) - latency
		latency = latency_total / latency_history.size()
		latency_history.clear()
#endregion

#region Game World Events
@rpc("authority", "call_remote", "reliable")
func spawn_player_node(client_id : int, position):
	get_node("../SceneManager/World").spawn_new_player(client_id, position)
	get_node("../SceneManager/World/Map/" + str(local_client_id)).set_physics_process(true)

@rpc("authority", "call_remote", "reliable")
func despawn_player_node(client_id : int):
	# Added this timer for now, because the World State Buffer is having race problems with player despawns.
	# Player gets despawned, then the buffer respawns them (buffer queue thinks they're still here)
	# Probably needs a proper fix. But doesn't seem to cause issues? yet?
	# Might also just go away when network latency > 0ms.
	await get_tree().create_timer(0.5).timeout
	get_node("../SceneManager/World").despawn_player(client_id)

func send_player_state(player_state):
	receive_player_state.rpc_id(1, player_state)

@rpc("any_peer", "unreliable_ordered")
func receive_player_state(_player_state):
	pass

func send_world_state(_world_state):
	pass

@rpc("any_peer", "unreliable_ordered")
func receive_world_state(world_state):
	# World state packets currently contain the following elements:
	# "T" - Timestamp // "P" - Position
	get_node("../SceneManager/World").update_world_state(world_state)
	get_node("../SceneManager/ClientDisplay").get_world_time(world_state["T"])
#endregion
