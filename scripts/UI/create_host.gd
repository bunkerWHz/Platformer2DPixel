extends Label
@onready var new_game_label: Label = $"../NewGameLabel"
@onready var main: Node2D = $"../../../.."

func select() -> void:
	main.peer.create_server(135)
	multiplayer.multiplayer_peer = main.peer
	multiplayer.peer_connected.connect(main.add_player)
	main.start()
	main.add_player()
