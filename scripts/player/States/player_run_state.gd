extends PlayerBaseState
@onready var sfx: AudioStreamPlayer = $RunSFX
@onready var timer: Timer = $RunTimer

func enter() -> void:
	play("run")
	sfx.play()
	timer.start()
func physics_update(delta: float) -> void:
	move(delta, false)
	
	if input.jump_just_pressed:
		change_state("jump")
	elif not object.is_on_floor():
		change_state("fall")
	elif input.x == 0:
		change_state("idle")

func exit()-> void:
	timer.stop()
func _on_run_timer_timeout() -> void:
	sfx.play()
