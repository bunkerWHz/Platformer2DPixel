extends Control
@onready var atk: Label = %ATK

func calculate():
	var sum : float = 0 
	
	for i in get_children():
		sum += i.get_ATK()
		
	atk.text = str(sum)
	
	Game.players[Game.players.find(self)].damage = sum
