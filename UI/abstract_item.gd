extends Sprite2D

@export var ID = "0"

func _ready() -> void:
	texture = load("res://assets/items/" + ItemData.get_texture(ID))


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		print(get_parent().get_parent().get_parent().get_parent().get_children())
		get_parent().get_parent().get_parent().get_parent().get_child(6).find_child("Inventory").add_item(ID)
		queue_free()
	
	
