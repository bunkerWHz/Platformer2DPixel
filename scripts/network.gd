extends VBoxContainer

@onready var new_game_label: Label = $NewGameLabel

var Ip_adress = '127.0.0.1'
var port = 49665
var peer = ENetMultiplayerPeer.new()

func add_player(id):
	Game.add_player(id)
	Game.players.append(id)
func _on_create_host_pressed() -> void:
	peer.create_server(port, 2)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	new_game_label.select()
	add_player(1)

func _on_join_host_pressed() -> void:
	peer.create_client(Ip_adress, port)
	multiplayer.multiplayer_peer = peer
	new_game_label.select()
