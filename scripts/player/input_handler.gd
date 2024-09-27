extends Node
@onready var jump_buffer_timer: Timer = $JumpBufferTimer

var x: float = 0.0
var jump_pressed: bool = false

var jump_just_pressed: bool = false:
	get:
		return jump_just_pressed
	set(value):
		jump_just_pressed = value
		if value: jump_buffer = true
		
var jump_buffer: bool:
	get:
		return not jump_buffer_timer.is_stopped()
	set(value):
		if value: jump_buffer_timer.start()
		else: jump_buffer_timer.stop()

func update()-> void:
	x = Input.get_axis("btn_left", "btn_right")
	jump_just_pressed = Input.is_action_just_pressed("btn_jump")
	jump_pressed = Input.is_action_pressed("btn_jump")
	
