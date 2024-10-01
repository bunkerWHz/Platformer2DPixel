class_name HitBox extends Area2D


signal health_changed( _heal_amount: float, _damage: float )

@onready var damage: float = get_parent().get_parent().damage

func take_damage(_damage: float) -> void:
	health_changed.emit(damage)


func _on_player_damage_changed(new_damage: float) -> void:
	damage = new_damage
