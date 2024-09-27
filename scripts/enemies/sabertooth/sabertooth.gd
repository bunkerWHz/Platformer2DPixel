extends CharacterBody2D

@onready var hit_box: HitBox = $Sprite2D/HitBox

@export var speed : float = -60
@export var health: float = 3
@export var damage: float = 1
var facing_rigth = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var ground_detecter: RayCast2D = $RayCast2D
@onready var wall_detecter: RayCast2D = $RayCast2D2
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _ready() -> void:
	hit_box.Damaged.connect(TakeDamage)
	animation_player.play("run")
	
func TakeDamage(_damage:float)->void:
	health -= _damage
	print("sab was hit by something")
	if health <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if (wall_detecter.is_colliding() or !ground_detecter.is_colliding()) && is_on_floor():
		change_direction()
		
	velocity.x = speed 
	move_and_slide()

func change_direction() -> void:
	facing_rigth = !facing_rigth
	scale.x = abs(scale.x) * -1 
	if facing_rigth:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1 
