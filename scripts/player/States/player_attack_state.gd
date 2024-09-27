extends PlayerBaseState


func enter() -> void:
	object.attacking = true
	play("attack")
	
func physics_update(delta: float) -> void:
	move(delta, false)
	
	if input.jump_just_pressed:
		change_state("jump")
	elif not object.is_on_floor():
		change_state("fall")
	elif input.x != 0:
		change_state("run")
	elif input.x == 0 and object.attacking == false:
		change_state("idle")

func exit()->void:
	object.attacking = false
