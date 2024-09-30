extends Sprite2D

@export var ID = "0"

func _ready() -> void:
	texture = load("res://assets/items/" + ItemData.get_texture(ID))


func _on_area_2d_body_entered(_body: Node2D) -> void:
	Game.main.find_child("Inventory").add_item(ID)
	queue_free()
	
	
