extends Node2D
class_name Checkpoint

@onready var animation: AnimationPlayer = $AnimationPlayer
@export var spawnspoint : bool = false
var activated : bool = false

func _ready() -> void:
	if spawnspoint:
		activate()


func activate() -> void:
	Game.current_checkpoint = self
	activated = true
	animation.play("activated")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and !activated:
		Game.current_checkpoint.animation.play("idle")
		Game.current_checkpoint.activated = false
		activate()
