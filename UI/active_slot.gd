extends Slot
class_name ActiveSlot

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is TextureRect and data.slot_type == slot_type	
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	super._drop_data(at_position, data)
