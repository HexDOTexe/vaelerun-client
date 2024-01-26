extends Node

var network = ENetMultiplayerPeer.new()
var ip = "127.0.0.1"
var port = 9999

var temp_name = "Player"
var connection_status = 0
var local_client_id

#region Server Interface
func _ready():
	pass

func connect_to_server():
	network.create_client(ip, port)
	network.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(network)
	
	#multiplayer.peer_connected.connect(client_connected)
	#multiplayer.peer_disconnected.connect(client_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
#endregion

#region Network Events
func connected_to_server():
	sync_client_information.rpc_id(1, multiplayer.get_unique_id(), temp_name,)
	connection_status = 1
	local_client_id = multiplayer.get_unique_id()
	print("Connected to server.")

func connection_failed():
	connection_status = 0
	print("Failed to connect.")

@rpc("any_peer","call_remote")
func sync_client_information(_client_id, _player):
	pass
#endregion

#region Game World Events
@rpc("authority", "call_remote", "reliable")
func spawn_player_node(client_id : int, position):
	get_node("../SceneManager/World").spawn_new_player(client_id, position)
	get_node("../SceneManager/World/Map/" + str(local_client_id)).set_physics_process(true)

@rpc("authority", "call_remote", "reliable")
func despawn_player_node(client_id : int):
	get_node("../SceneManager/World").despawn_player(client_id)

func send_player_state(player_state):
	#print(player_state)
	receive_player_state.rpc_id(1, player_state)
	pass

@rpc("any_peer", "unreliable_ordered")
func receive_player_state(player_state):
	pass

func send_world_state(world_state):
	pass

@rpc("any_peer", "unreliable_ordered")
func receive_world_state(world_state):
	get_node("../SceneManager/World").update_world_state(world_state)
	pass
#endregion
