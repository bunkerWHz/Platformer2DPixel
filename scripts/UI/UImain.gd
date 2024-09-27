extends CanvasLayer
@onready var coin_counter: Label = $CoinCounter

func _ready() -> void:
	Game.gold_coins_gained.connect(update_coin_display)

func update_coin_display()-> void:
	coin_counter.text = str(Game.gold_coins)
