class_name HitBox extends Area2D


signal Damaged( damage: float )
@export var damage: float = 1

func TakeDamage(_damage: float) -> void:
	Damaged.emit(damage)
