extends Node
class_name HealthComponent

@onready var max_health: float = get_parent().max_health
@onready var current_health: float = max_health : set = set_current_health, get = get_current_health
@export var regeneration_rate: float = 1.0
@export var regeneration_interval: float = 10.0
@export var immortality: bool = false : set = set_immortality, get = get_immortality

signal health_changed(diff: float)
signal max_health_changed(diff: float)
signal health_is_zero()

var timer: Timer
var health_bar: ProgressBar
var immortality_timer: Timer = null

func setup_healthbar() -> void:
	health_bar.name = "HealthBar"
	health_bar.show_percentage = false
	health_bar.size.x = 32
	health_bar.size.y = 4
	health_bar.position.x = -16
	health_bar.position.y = -24
	
func _ready():
	
	# Create Timer if it doesn't exist
	if not has_node("RegenerationTimer"):
		timer = Timer.new()
		timer.name = "RegenerationTimer"
		add_child(timer)
	else:
		timer = $RegenerationTimer
	
	# Set up the Timer
	timer.wait_time = regeneration_interval
	timer.connect("timeout", Callable(self, "_on_regeneration_timer_timeout"))
	timer.start()
	
	# Create ProgressBar if it doesn't exist
	if not has_node("HealthBar"):
		health_bar = ProgressBar.new()
		
		setup_healthbar()
		add_child(health_bar)
	else:
		health_bar = $HealthBar
	
	# Set up the ProgressBar
	health_bar.max_value = max_health
	health_bar.value = current_health
	
	_update_health_bar()

func take_damage(amount: float):
	current_health = max(0, current_health - amount)
	_update_health_bar()
	if current_health == 0:
		die()

func heal(amount: float):
	current_health = min(max_health, current_health + amount)
	_update_health_bar()

func _on_regeneration_timer_timeout():
	heal(regeneration_rate)

func _update_health_bar():
	health_bar.value = current_health

func die() -> void:
	if get_parent() is Player:
		Game.respawn_player(get_parent())
	else:
		get_parent().queue_free()

# Optional: Function to set custom colors for the health bar
func set_health_bar_colors(bg_color: Color, fill_color: Color):
	health_bar.add_theme_color_override("theme_override_colors/background", bg_color)
	health_bar.add_theme_color_override("theme_override_colors/fill", fill_color)

# Optional: Function to set the position of the health bar relative to the parent
#func set_health_bar_position(position: Vector2):
	#health_bar.position = position

# Optional: Function to set the size of the health bar
func set_health_bar_size(size: Vector2):
	health_bar.custom_minimum_size = size
	health_bar.size = size


func set_immortality(value: bool) -> void:
	immortality = value
	
func get_immortality() -> bool:
	return immortality

func set_temporary_immortality(time: float) -> void:
	if immortality_timer == null:
		immortality_timer = Timer.new() 
		immortality_timer.one_shot = true
		add_child(immortality_timer)
		
	if immortality_timer.timeout.is_connected(set_immortality):
		immortality_timer.timeout.disconnect(set_immortality)
	immortality_timer.set_wait_time(time)
	immortality_timer.timeout.connect(set_immortality.bind(false))
	immortality = true
	immortality_timer.start()
	
func set_current_health(value: float) -> void:
	if value <= current_health and immortality:
		return
	var min_health = clampi(value, 0, max_health)
	if min_health != current_health:
		var diff = min_health - current_health
		current_health = value
		health_changed.emit(diff)
		if current_health == 0:
			health_is_zero.emit()
			
func get_current_health() -> float:
	return current_health
	
func set_max_health(value: float) -> void:
	var min_value = 1 if value <= 0 else value
	if not min_value == max_health:
		max_health += value
		max_health_changed.emit(value)
		if current_health > max_health:
			current_health = max_health
		
func get_max_health() -> float:
	return max_health
