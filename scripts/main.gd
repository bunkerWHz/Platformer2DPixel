extends Node2D

@onready var main_menu: CanvasLayer = $MainMenu
@onready var pause_menu: CanvasLayer = $PauseMenu
@onready var world: Node2D = $World
@onready var transition: CanvasLayer = $Transition

var peer = ENetMultiplayerPeer.new()
var level_1 = preload("res://scenes/Levels/level_1.tscn")
@export var pirate: PackedScene = preload("res://scenes/Characters/pirate.tscn")

func start():
	Game.main.transition.fade_out()
	Game.main.main_menu.disable()
	await Game.main.transition.faded_out
	get_tree().paused = true
	Game.main.main_menu.hide()
	Game.main.world.load_level("level_1")
	Game.main.transition.fade_in()
	await Game.main.transition.faded_in
	get_tree().paused = false
	
func add_player(id = 1):
	var player = pirate.instantiate()
	player.name = str(id)
	add_child(player, true)
	
func _ready() -> void:
	Game.main = self
	transition.fade_in()
	main_menu.show()
	await transition.faded_in
	main_menu.enable()
