extends Control
@onready var inventory: GridContainer = $Inventory
@onready var active_slot: ActiveSlot = $Character/ActiveSlot
signal active_slot_changed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		visible = !visible
		if visible == true:
			get_tree().paused = true
		else:
			get_tree().paused = false
			
func _ready() -> void:
	visible = false

func _physics_process(delta: float) -> void:
	if active_slot.texture_rect.texture != null:
		active_slot_changed.emit()

func _on_active_slot_changed() -> void:
	if active_slot.texture_rect.texture != null:
		Game.player.update_weapon_texture(active_slot.texture_rect.texture)
