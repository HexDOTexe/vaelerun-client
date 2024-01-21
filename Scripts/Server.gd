extends Node

var network = ENetMultiplayerPeer.new()
var ip = "127.0.0.1"
var port = 9999

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
	print("Connected to server.")
	sync_client_information.rpc_id(1, "Player", multiplayer.get_unique_id())

func connection_failed():
	print("Failed to connect.")

@rpc("any_peer","call_remote")
func sync_client_information(_player, _client_id):
	pass

@rpc("any_peer")
func spawn_player_node(client_id : int, character_name: String):
	#print_log("world", "Spawning new player node @: ")
	pass
	# Code To Spawn Player Node
