extends Area2D
@onready var sprite: Sprite2D = $Sprite2D
@export var speed: float = 200
@export var direction: int = 1
@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	hit_box.Damaged.connect(TakeDamage)

func _physics_process(delta: float) -> void:
	if direction > 0:
		global_position += Vector2( speed * delta, 0)
	else:
		sprite.flip_h = false
		global_position -= Vector2( speed * delta, 0)

func TakeDamage(_damage:float)->void:
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
