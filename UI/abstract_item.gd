extends Sprite2D
@onready var sfx: AudioStreamPlayer = $PowerupSFX
@export var ID = "0"

func _ready() -> void:
	texture = load("res://assets/items/" + ItemData.get_texture(ID))
	scale.x = 0.05
	scale.y = 0.05

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		sfx.play()
		visible = false
		Game.main.ui.find_child("Inventory").add_item(ID)
		
func _on_powerup_sfx_finished() -> void:
	queue_free()
