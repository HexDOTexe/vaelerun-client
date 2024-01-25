extends Node

var network = ENetMultiplayerPeer.new()
var ip = "127.0.0.1"
var port = 9999

var temp_name = "Player"
var connection_status = 0

func _ready():
	pass

func connect_to_server():
	network.create_client(ip, port)
	network.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(network)
	
	#multiplayer.peer_connected.connect(player_connected)
	#multiplayer.peer_disconnected.connect(player_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)

func connected_to_server():
	sync_client_information.rpc_id(1, multiplayer.get_unique_id(), temp_name,)
	connection_status = 1
	print("Connected to server.")

func connection_failed():
	connection_status = 0
	print("Failed to connect.")

@rpc("any_peer","call_remote")
func sync_client_information(_client_id, _player):
	pass



@rpc("any_peer","call_local")
func spawn_player_node(client_id : int, position):
	get_node("../SceneManager/World").spawn_new_player(client_id, position)

@rpc("any_peer")
func despawn_player_node(client_id : int):
	pass

@rpc("any_peer")
func send_node_position(position, rotation, speed):
	var id = multiplayer.get_remote_sender_id()
	receive_node_position.rpc_id(1, id, position, rotation, speed)

@rpc("any_peer")
func receive_node_position(position, rotation, speed):
	pass
