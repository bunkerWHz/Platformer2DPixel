extends Node2D

var levels_map : Dictionary = {
	"level_1" : "res://scenes/Levels/level_1.tscn"
}

var current_level : Node
func load_level(level_name: String) -> void:
	current_level = load(levels_map[level_name]).instantiate()
	add_child(current_level, true)
	
func unload() -> void:
	current_level.queue_free()
	current_level = null
