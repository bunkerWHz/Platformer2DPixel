extends Area2D
@onready var sfx: AudioStreamPlayer = $PowerupSFX
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _on_player_entered(_body: Node2D) -> void:
	sfx.play()
	if _body is Player:
		_body.sword = true
	sprite.visible = false
	collision.set_deferred("disabled", true)
	
func _on_powerup_sfx_finished() -> void:
	queue_free()
