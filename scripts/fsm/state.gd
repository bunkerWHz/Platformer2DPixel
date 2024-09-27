extends Node
class_name State

var object
var fsm


func enter() -> void:
	pass
	
func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass

func change_state(next_state) -> void:
	fsm.change_state(next_state)
