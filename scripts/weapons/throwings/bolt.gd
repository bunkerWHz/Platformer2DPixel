extends Area2D
@onready var sprite: Sprite2D = $Sprite2D
@export var speed: float = 200
@export var direction: int = 1
@onready var hit_box: HitBox = $Sprite2D/HitBox
@export var damage: float = 1

func _ready() -> void:
	hit_box.health_changed.connect(take_damage)

func _physics_process(delta: float) -> void:
	if direction > 0:
		global_position += Vector2( speed * delta, 0)
	else:
		sprite.flip_h = false
		global_position -= Vector2( speed * delta, 0)

func take_damage(_damage:float)->void:
	hit_box.take_damage(damage)


func _on_timer_timeout() -> void:
	queue_free()
