extends TextureRect

@export var slot_type : int = 0
@export var ATK = 0:
	set(value):
		ATK = value
		%debug.text = str(ATK)
		if get_parent() is PassiveSlot or get_parent() is ActiveSlot:
			get_parent().get_parent().calculate()
		
		if get_parent() is ActiveSlot and value == 0:
			owner.get_parent().owner.find_child("player").set_speed(value)
			

@onready var property: Dictionary = {"texture" : texture,"ATK": ATK,"slot_type": slot_type}: 
	set(value):
		property = value
		texture = property["texture"]
		ATK = property["ATK"]
		slot_type = property["slot_type"]
