extends PlayerBaseState
@onready var sfx: AudioStreamPlayer = $JumpSFX

var variable_jump_height: bool

func enter()-> void:
	play("jump")
	sfx.play()
	object.velocity.y = - 300
	object.velocity.x += input.x * object.max_speed
	variable_jump_height = false
	input.jump_buffer = false

func physics_update(delta: float)-> void:
	move(delta, true)
	
	if not variable_jump_height and not input.jump_pressed:
		variable_jump_height = true
		if object.velocity.y <= 0:
			object.velocity.y /= 2   
	if object.velocity.y >= 0:
		change_state("fall")
