extends Area2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx: AudioStreamPlayer = $CollectSFX

func _ready() -> void:
	sprite.play("idle")


func _on_body_entered(_body: Node2D) -> void:
	sprite.play("collect")
	sfx.play()
	Game.gold_coins_gain(1)

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
