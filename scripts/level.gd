extends Node2D

@onready var player_start_position: Marker2D = $PlayerStartPosition

func pause() -> void:
	get_tree().paused = true
	Game.main.pause_menu.selection_index = 0
	Game.main.pause_menu.show()
	Game.main.pause_menu.enable()

func resume() -> void:
	get_tree().paused = false
	Game.main.pause_menu.hide()
	Game.main.pause_menu.disable()
	
func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		pause()
		
func _ready() -> void:
	print(Game.players[0].damage)
