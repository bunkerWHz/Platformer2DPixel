extends Label
@onready var main: Node2D = $"../../../.."

func select() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	main.start()
