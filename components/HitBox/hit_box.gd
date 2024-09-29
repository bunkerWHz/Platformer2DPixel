class_name HitBox extends Area2D


signal health_changed( _heal_amount: float, _damage: float )

@onready var damage: float

func take_damage(_damage: float) -> void:
	health_changed.emit(damage)
