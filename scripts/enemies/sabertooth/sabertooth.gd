extends CharacterBody2D

@onready var hit_box: HitBox = $Sprite2D/HitBox
@onready var health_component: HealthComponent = $HealthComponent

@export var speed : float = -60
@export var max_health: float = 10
@export var current_health: float 
@export var damage: float = 1
@export var health_regen: float = 0.5
var facing_right = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var ground_detecter: RayCast2D = $RayCast2D
@onready var wall_detecter: RayCast2D = $RayCast2D2
@onready var animation_player: AnimationPlayer = $AnimationPlayer




func _ready() -> void:
	current_health = max_health
	hit_box.health_changed.connect(take_damage)
	animation_player.play("run")
	
func take_damage(_damage:float)->void:
	health_component.take_damage(damage)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if (wall_detecter.is_colliding() or !ground_detecter.is_colliding()) && is_on_floor():
		change_direction()
		
	velocity.x = speed 
	move_and_slide()

func change_direction() -> void:
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1 
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1 
