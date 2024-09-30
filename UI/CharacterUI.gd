extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		visible = !visible
		if visible == true:
			get_tree().paused = true
		else:
			get_tree().paused = false

func _ready() -> void:
	visible = false
