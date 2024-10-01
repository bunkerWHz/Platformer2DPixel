extends PlayerBaseState

@onready var throwing_buffer_timer: Timer = $ThrowingBufferTimer
@onready var projects: Node = $"../../Projects"

var proj = preload("res://scenes/weapons/bolt.tscn")



func enter() -> void:
	object.throwing = true
	throwing_buffer_timer.start()
	
	var new_proj = proj.instantiate()
	new_proj.direction = object.direction
	if new_proj.direction == 1:
		new_proj.global_position = Vector2(object.global_position.x + 30, object.global_position.y)
	else:
		new_proj.global_position = Vector2(object.global_position.x - 30, object.global_position.y)


	projects.add_child(new_proj)
	
	
func physics_update(delta: float) -> void:
	move(delta, false)
	
	if input.jump_just_pressed:
		change_state("jump")
	elif not object.is_on_floor():
		change_state("fall")
	elif input.x != 0:
		change_state("run")
	elif input.x == 0 and object.throwing == false:
		change_state("idle")


func _on_throwing_buffer_timer_timeout() -> void:
	object.throwing = false
