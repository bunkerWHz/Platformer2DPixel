extends CharacterBody2D
class_name Player

@onready var sprite: Sprite2D = $Sprite2D
@onready var hurt_box: HurtBox = $Sprite2D/HurtBox
@onready var hit_box: HitBox = $Sprite2D/HitBox
@onready var weapon_hitbox: CollisionShape2D = $Sprite2D/HitBox/WeaponCollision
@onready var health_component: HealthComponent = $HealthComponent
@onready var weapon_marker: Marker2D = $Sprite2D/WeaponMarker
@onready var weapon: Sprite2D = $Sprite2D/Weapon

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

signal damage_changed(new_damage: float)
@export var damage: float = 1 : 
	get : return damage
	set(value):
		damage = value
		damage_changed.emit(value)
		
@export var max_health: float = 10
@export var current_health: float
@export var health_regen: float = 1

@export var attacking: bool = false
@export var throwing: bool = false

@export var melee_weapon: bool = false:
	get: return melee_weapon
	set(value):
		if melee_weapon == value: return
		melee_weapon = value
			
			
var direction = 1: 
	get: return direction
	set(value):
		if value == 0 or value == direction: return
		direction = value
		sprite.scale.x = direction
		

	
func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	Game.player = self
	current_health = max_health
	fsm.change_state("idle")
	position = Vector2(50, 100)
	hit_box.health_changed.connect(take_damage)
	
	weapon_hitbox.position = weapon_marker.position
	if melee_weapon:
		weapon.position = weapon_marker.position
		#weapon_hitbox.shape.size.x = weapon.size.x
		#weapon_hitbox.shape.size.y = weapon.size.y
		#
func _process(_delta: float) -> void:
	pass
		
func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		input.update()
		fsm.physics_update(delta)
	if attacking:
		weapon_hitbox.disabled = false
	else:
		weapon_hitbox.disabled = true
	if position.y >= death_distance:
		die()

func die() -> void:
	Game.respawn_player(self)
	
func take_damage() -> void:
	health_component.take_damage(damage)
	
#func heal(_heal_amount: float) -> void:
	#health_component.heal(_heal_amount)
	#

func update_weapon_texture(texture):
	weapon.texture = texture
