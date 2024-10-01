extends Node
class_name HealthComponent

@onready var max_health: float = get_parent().max_health
@onready var current_health: float = max_health : set = set_current_health, get = get_current_health
@onready var health_regen: float = get_parent().health_regen

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
func _process(_delta: float) -> void:
	health_bar.position.x = get_parent().global_position.x - 12
	health_bar.position.y = get_parent().global_position.y - 22
	
func take_damage(damage: float):
	current_health = max(0, current_health - damage)
	print(damage," <= damage, take damage, current healths = ", current_health)
	_update_health_bar()
	if current_health == 0:
		die()

func heal(amount: float):
	current_health = min(max_health, current_health + amount)
	_update_health_bar()

func _on_regeneration_timer_timeout():
	heal(health_regen)

func _update_health_bar():
	health_bar.value = current_health

func die() -> void:
	if get_parent() is Player:
		Game.respawn_player(get_parent())
	else:
		get_parent().queue_free()

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
	var min_health = clampf(value, 0, max_health)
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
