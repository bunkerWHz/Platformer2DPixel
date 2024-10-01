extends Node2D

var main
var current_checkpoint : Checkpoint

signal gold_coins_gained(int)

var gold_coins: int

func gold_coins_gain(coins_gained: int) -> void:
	gold_coins += coins_gained
	gold_coins_gained.emit()
	
func respawn_player(_player: Player) -> void:
	if current_checkpoint:
		_player.position = current_checkpoint.global_position
	else:
		_player.position = Vector2(100, 100)
		
