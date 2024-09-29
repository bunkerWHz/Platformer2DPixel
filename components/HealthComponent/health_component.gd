class_name HealthComponent extends ProgressBar

var current_health: float
@onready var max_health: float = get_parent().max_health
@onready var health_regen = get_parent().health_regen

func _ready() -> void:
	current_health = max_health
	max_value = max_health
	value = current_health
	setup_healthbar()
	
func setup_healthbar() -> void:
	show_percentage = false
	size.x = 32
	size.y = 4
	position.x = -16
	position.y = -24
	
func _physics_process(_delta: float) -> void:
	health_changed()
			
func take_damage(damage: float) -> void:
	self.current_health -= damage
	if current_health <= 0:
		die()
		
func health_changed() -> void:
	value = current_health
	
func heal(heal_amount: float):
	current_health += heal_amount
	current_health = min(current_health, max_health) 
	health_changed() 
	
func die() -> void:
	if get_parent() is Player:
		Game.respawn_player(get_parent())
	else:
		get_parent().queue_free()


func _on_regen_tick_timer_timeout() -> void:
	current_health += 1
	health_changed()
