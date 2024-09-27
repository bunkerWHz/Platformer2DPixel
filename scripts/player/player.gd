extends CharacterBody2D
class_name Player

@onready var sprite: Sprite2D = $Sprite2D
@onready var hurt_box: HurtBox = $Sprite2D/HurtBox
@onready var hit_box: HitBox = $Sprite2D/HitBox
@onready var weapon_hitbox: CollisionShape2D = $Sprite2D/HitBox/CollisionShape2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var fsm: Node = $FSM
@onready var input: Node = $InputHandler
@onready var player_camera: Camera2D = $Camera2D

@export var max_speed: float = 260.0
@export var acceleration: float = 900.0
@export var air_multiplier: float = 0.7
@export var jump_gravity: float = 600.0
@export var fall_gravity: float = 500.0
@export var terminal_velocity: float = 250.0
@export var death_distance: float = 700.0

@export var damage: float = 1
@export var health: float = 5

@export var attacking: bool = false
@export var throwing: bool = false

var sword: bool = false:
	get: return sword
	set(value):
		if sword == value: return
		sword = value
		var current_anim = animation.current_animation
		var target_anim = current_anim
		if value:
			target_anim += "_sword"
		else:
			target_anim = target_anim.replace("_sword", "")
		if animation.has_animation(target_anim):
			var progress = animation.frame_progress
			var frame = animation.frame
			animation.play(target_anim)
			animation.set_frame_and_progress(frame, progress)
			
			
var direction = 1: 
	get: return direction
	set(value):
		if value == 0 or value == direction: return
		direction = value
		sprite.scale.x = direction
		
		
func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	fsm.change_state("idle")
	position = Vector2(50, 100)
	hit_box.Damaged.connect(TakeDamage)
	
func _process(_delta: float) -> void:
	if attacking:
		weapon_hitbox.disabled = false
	else:
		weapon_hitbox.disabled = true
func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		input.update()
		fsm.physics_update(delta)
		
	if position.y >= death_distance:
		die()

func die() -> void:
	Game.respawn_player(self)
	health = 2
	
func TakeDamage(_damage: float) -> void:
	health -= damage
	if health <= 0:
		die()
