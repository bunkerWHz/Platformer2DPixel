class_name HurtBox extends Area2D

func _ready() -> void:
	area_entered.connect( AreaEntered )
	
func AreaEntered(hitbox : HitBox) -> void:
	if hitbox == null:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		
