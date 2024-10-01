extends PlayerBaseState

func enter()-> void:
	play("idle")

func physics_update(delta: float) -> void:
	move(delta, false)
	
	if input.jump_just_pressed:
		change_state("jump")
	elif not object.is_on_floor() or input.jump_just_pressed and Input.is_action_pressed("btn_down"):
		owner.position.y += 1
		change_state("fall")
	elif input.x != 0:
		change_state("run")
	elif Input.is_action_just_pressed("btn_attack"):
		change_state("attack")
	elif Input.is_action_just_pressed("btn_throw"):
		change_state("throw")
