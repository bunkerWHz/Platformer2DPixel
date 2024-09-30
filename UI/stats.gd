extends TextureRect

@export var slot_type : int = 0
@export var ATK = 0:
	set(value):
		ATK = value
		%debug.text = str(ATK)
		if get_parent() is PassiveSlot:
			get_parent().get_parent().calculate()
			
			

@onready var property: Dictionary = {"texture" : texture,"ATK": ATK,"slot_type": slot_type}: 
	set(value):
		property = value
		texture = property["texture"]
		ATK = property["ATK"]
		slot_type = property["slot_type"]
