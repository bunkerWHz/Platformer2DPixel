extends State
class_name PlayerBaseState

var input:
	get: return object.input

func play(animation: String) -> void:
	if object.sword and object.animation.has_animation(animation + "_sword"):
		animation += "_sword"
	object.animation.play(animation)
	
func accelerate(delta:float, direction = input.x) -> void:
	var mult = object.air_multiplier if not object.is_on_floor() else 1.0
	object.velocity.x = move_toward(object.velocity.x, object.max_speed * direction, object.acceleration * mult * delta)

func apply_gravity(delta:float) -> void:
	var g = object.jump_gravity if fsm.current_state == "jump" else object.fall_gravity
	object.velocity.y = move_toward(object.velocity.y, object.terminal_velocity, g * delta)

func move(delta: float, apply_g: bool, update_direction: bool = true, direction: float = input.x):
	accelerate(delta, direction)
	if apply_g: apply_gravity(delta)
	if update_direction: object.direction = direction
	object.move_and_slide()
